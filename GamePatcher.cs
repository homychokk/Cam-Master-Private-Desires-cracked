using System;
using System.Linq;
using Mono.Cecil;
using Mono.Cecil.Cil;

class Program
{
    static void PatchReturnZero(MethodDefinition method) {
        if (method == null || !method.HasBody) return;
        var processor = method.Body.GetILProcessor();
        var first = method.Body.Instructions[0];
        if (first.OpCode == OpCodes.Ldc_I4_0 && method.Body.Instructions[1].OpCode == OpCodes.Ret) return;
        processor.InsertBefore(first, processor.Create(OpCodes.Ldc_I4_0));
        processor.InsertBefore(first, processor.Create(OpCodes.Ret));
    }

    static void PatchReturnTrue(MethodDefinition method) {
        if (method == null || !method.HasBody) return;
        var processor = method.Body.GetILProcessor();
        var first = method.Body.Instructions[0];
        if (first.OpCode == OpCodes.Ldc_I4_1 && method.Body.Instructions[1].OpCode == OpCodes.Ret) return;
        processor.InsertBefore(first, processor.Create(OpCodes.Ldc_I4_1));
        processor.InsertBefore(first, processor.Create(OpCodes.Ret));
    }

    static void Main(string[] args)
    {
        string asmPath = args.Length > 0 ? args[0] : "Assembly-CSharp.dll";
        string managedDir = System.IO.Path.GetDirectoryName(System.IO.Path.GetFullPath(asmPath));
        
        try 
        {
            Console.WriteLine("Loading assembly from: " + asmPath);
            var resolver = new DefaultAssemblyResolver();
            resolver.AddSearchDirectory(managedDir);
            
            var parameters = new ReaderParameters { AssemblyResolver = resolver, ReadWrite = true };
            using (var module = ModuleDefinition.ReadModule(asmPath, parameters))
            {
                // Hack 1: Battle Pass Premium
                var bpType = module.Types.FirstOrDefault(t => t.Name == "BattlePass");
                var unlockMethod = bpType != null ? bpType.Methods.FirstOrDefault(m => m.Name == "UnlockPremium") : null;
                var windowType = module.Types.FirstOrDefault(t => t.Name == "BattlePassWindow");
                var awakeMethod = windowType != null ? windowType.Methods.FirstOrDefault(m => m.Name == "Awake") : null;
                
                if (unlockMethod != null && awakeMethod != null) {
                    var processor = awakeMethod.Body.GetILProcessor();
                    var firstInstr = awakeMethod.Body.Instructions[0];
                    if (firstInstr.OpCode != OpCodes.Call || firstInstr.Operand != module.ImportReference(unlockMethod)) {
                        var callInstr = processor.Create(OpCodes.Call, module.ImportReference(unlockMethod));
                        processor.InsertBefore(firstInstr, callInstr);
                        Console.WriteLine("Battle Pass patched.");
                    }
                }
                
                // Hack 2: InGamePurchase bypass Steam
                var purType = module.Types.FirstOrDefault(t => t.Name == "InGamePurchase");
                var buyMethod = purType != null ? purType.Methods.FirstOrDefault(m => m.Name == "Buy") : null;
                var getMethod = purType != null ? purType.Methods.FirstOrDefault(m => m.Name == "Get" && m.Parameters.Count == 2) : null;
                
                if (buyMethod != null && getMethod != null) {
                    var processor2 = buyMethod.Body.GetILProcessor();
                    var firstInstr2 = buyMethod.Body.Instructions[0];
                    if (firstInstr2.OpCode != OpCodes.Ldarg_0 || buyMethod.Body.Instructions[1].OpCode != OpCodes.Ldarg_0) {
                        var loadArg0 = processor2.Create(OpCodes.Ldarg_0); // this
                        var loadArg0ForFld = processor2.Create(OpCodes.Ldarg_0); // this
                        var rewardsField = purType.Fields.FirstOrDefault(f => f.Name == "rewards");
                        var loadFld = processor2.Create(OpCodes.Ldfld, rewardsField); // this.rewards
                        var loadTrue = processor2.Create(OpCodes.Ldc_I4_1); // true
                        var callGet = processor2.Create(OpCodes.Callvirt, module.ImportReference(getMethod));
                        var popInstr = processor2.Create(OpCodes.Pop); 
                        var retInstr = processor2.Create(OpCodes.Ret);
                        
                        processor2.InsertBefore(firstInstr2, loadArg0);
                        processor2.InsertBefore(firstInstr2, loadArg0ForFld);
                        processor2.InsertBefore(firstInstr2, loadFld);
                        processor2.InsertBefore(firstInstr2, loadTrue);
                        processor2.InsertBefore(firstInstr2, callGet);
                        processor2.InsertBefore(firstInstr2, popInstr);
                        processor2.InsertBefore(firstInstr2, retInstr);
                        Console.WriteLine("InGamePurchase patched.");
                    }
                }

                // Hack 3: Remove Cooldowns
                var shopBundleData = module.Types.FirstOrDefault(t => t.Name == "ShopBundleData");
                if (shopBundleData != null) PatchReturnZero(shopBundleData.Methods.FirstOrDefault(m => m.Name == "get_ExpiresTimeInHours"));
                
                var inGamePurchaseData = module.Types.FirstOrDefault(t => t.Name == "InGamePurchaseData");
                if (inGamePurchaseData != null) PatchReturnZero(inGamePurchaseData.Methods.FirstOrDefault(m => m.Name == "get_FreeChestDelayInHours"));
                
                var dailyBattlePassData = module.Types.FirstOrDefault(t => t.Name == "DailyBattlePassData");
                if (dailyBattlePassData != null) PatchReturnZero(dailyBattlePassData.Methods.FirstOrDefault(m => m.Name == "get_CooldownTimeInMinutes"));
                
                Console.WriteLine("Cooldowns removed.");

                // Hack 4: Infinite Energy
                var energyType = module.Types.FirstOrDefault(t => t.Name == "Energy");
                if (energyType != null) PatchReturnTrue(energyType.Methods.FirstOrDefault(m => m.Name == "get_IsInfinity"));
                Console.WriteLine("Infinite energy enabled.");

                Console.WriteLine("Saving modified assembly...");
                module.Write();
                Console.WriteLine("Done! ULTIMATE EDITION Patched successfully.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.ToString());
        }
    }
}
