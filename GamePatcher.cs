using System;
using System.Linq;
using Mono.Cecil;
using Mono.Cecil.Cil;

class Program
{
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
                var bpType = module.Types.FirstOrDefault(t => t.Name == "BattlePass");
                var unlockMethod = bpType != null ? bpType.Methods.FirstOrDefault(m => m.Name == "UnlockPremium") : null;
                
                if (unlockMethod == null) {
                    Console.WriteLine("Could not find BattlePass.UnlockPremium!");
                    return;
                }
                
                var windowType = module.Types.FirstOrDefault(t => t.Name == "BattlePassWindow");
                var awakeMethod = windowType != null ? windowType.Methods.FirstOrDefault(m => m.Name == "Awake") : null;
                
                if (awakeMethod == null) {
                    Console.WriteLine("Could not find BattlePassWindow.Awake!");
                    return;
                }
                
                Console.WriteLine("Injecting UnlockPremium call into Awake...");
                
                var processor = awakeMethod.Body.GetILProcessor();
                var firstInstr = awakeMethod.Body.Instructions[0];
                
                var callInstr = processor.Create(OpCodes.Call, module.ImportReference(unlockMethod));
                processor.InsertBefore(firstInstr, callInstr);
                
                Console.WriteLine("Saving modified assembly...");
                module.Write();
                Console.WriteLine("Done! Patched successfully.");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error: " + ex.ToString());
        }
    }
}
