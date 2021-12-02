using Fonet;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Xml.Xsl;

namespace XslFOSample
{
    class Program
    {
        static void Main(string[] args)
        {
#if DEBUG
            args = new string[] {
                @"C:\temp\Sample1",
                @"C:\Users\emili\source\repos\xslfo-sample\XslFOSample\Samples\Sample1.xml",
                @"C:\Users\emili\source\repos\xslfo-sample\XslFOSample\Samples\Sample1.xsl"
            };
#endif
            if (args.Length != 3)
            {
                Console.WriteLine("usage: XslTransformer <output directory> <xml path> <xsl path>");
                return;
            }

            string outputDirectory = args[0];
            string xmlPath = args[1];
            string xslPath = args[2];

            Console.WriteLine($"Output directory: {outputDirectory}");
            Console.WriteLine($"XML: {xmlPath}");
            Console.WriteLine($"XSL: {xslPath}");

            Directory.CreateDirectory(outputDirectory);

            if (!File.Exists(xmlPath))
            {
                Console.WriteLine($"File not found: {xmlPath}");
                return;
            }

            if (!File.Exists(xslPath))
            {
                Console.WriteLine($"File not found: {xmlPath}");
                return;
            }

            string tempPath = Path.GetTempFileName();
            Console.WriteLine($"Temp path: {tempPath}");

            string outputFilename = DateTime.Now.ToString("yyyyMMddHHmmss") + ".pdf";
            string outputPath = Path.Combine(outputDirectory, outputFilename);

            Console.WriteLine($"Output path: {outputPath}");

            try
            {
                XslCompiledTransform xslt = new XslCompiledTransform();
                xslt.Load(xslPath);
                xslt.Transform(xmlPath, tempPath);

                FonetDriver driver = FonetDriver.Make();

                driver.Render(tempPath, outputPath);

                File.Delete(tempPath);

                Console.WriteLine("Done");
            }
            catch (Exception e)
            {
                Console.Error.WriteLine(e.Message);
            }
        }
    }
}
