"use client";
import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form";
import { Input } from "@/components/ui/input";
import { PasswordInput } from "@/components/ui/password-input";
import { zodResolver } from "@hookform/resolvers/zod";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import * as z from "zod";
import { useState } from "react";
import * as XLSX from "xlsx"; // XLSX for Excel handling
import { saveAs } from "file-saver"; // For exporting form data as Excel

const formSchema = z.object({
  email: z.string().email(),
  password: z.string(),
});

export default function LoginPage() {
  const router = useRouter();
  const form = useForm<z.infer<typeof formSchema>>({
    resolver: zodResolver(formSchema),
    defaultValues: {
      email: "",
      password: "",
    },
  });

  const [fileData, setFileData] = useState<any[]>([]); // Store parsed Excel data
  const [file, setFile] = useState<File | null>(null); // Store selected file

  // Handle form submission
  const handleSubmit = (data: z.infer<typeof formSchema>) => {
    console.log("login validation passed");
    router.push("/dashboard");
  };

  // Handle file upload (Excel or PDF)
  const handleFileUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
    const selectedFile = event.target.files?.[0];
    if (selectedFile) {
      setFile(selectedFile);

      if (selectedFile.type === "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
        // If Excel file is uploaded, parse it
        const reader = new FileReader();
        reader.onload = (e) => {
          const data = new Uint8Array(e.target?.result as ArrayBuffer);
          const workbook = XLSX.read(data, { type: "array" });
          const sheetName = workbook.SheetNames[0];
          const worksheet = XLSX.utils.sheet_to_json(workbook.Sheets[sheetName]);
          setFileData(worksheet); // Store parsed data
        };
        reader.readAsArrayBuffer(selectedFile);
      } else if (selectedFile.type === "application/pdf") {
        console.log("PDF file uploaded:", selectedFile.name); // Handle PDF logic as needed
      }
    }
  };

  // Handle form data export as Excel file
  const handleFormDataExport = () => {
    const data = [
      ["Email", form.getValues("email")],
      ["Password", form.getValues("password")],
    ];
    const ws = XLSX.utils.aoa_to_sheet(data); // Convert array to worksheet
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "Form Data");
    const wbout = XLSX.write(wb, { bookType: "xlsx", type: "array" });
    const blob = new Blob([wbout], { type: "application/octet-stream" });
    saveAs(blob, "form-data.xlsx");
  };

  return (
    <>
      <Card className="w-full max-w-sm">
        <CardHeader>
          <CardTitle>Login</CardTitle>
          <CardDescription>Login to your account</CardDescription>
        </CardHeader>
        <CardContent>
          <Form {...form}>
            <form
              className="flex flex-col gap-4"
              onSubmit={form.handleSubmit(handleSubmit)}
            >
              <FormField
                control={form.control}
                name="email"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Email</FormLabel>
                    <FormControl>
                      <Input placeholder="john@doe.com" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="password"
                render={({ field }) => (
                  <FormItem>
                    <FormLabel>Password</FormLabel>
                    <FormControl>
                      <PasswordInput placeholder="••••••••" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              {/* File Upload (Excel or PDF) */}
              <FormItem>
                <FormLabel>Upload PDF or Excel</FormLabel>
                <FormControl>
                  <Input type="file" accept=".pdf,.xlsx" onChange={handleFileUpload} />
                </FormControl>
              </FormItem>

              {/* Button to Export Form Data as Excel */}
              <Button type="button" onClick={handleFormDataExport}>
                Export Form Data as Excel
              </Button>

              <Button type="submit">Login</Button>
            </form>
          </Form>

          {/* Display Uploaded Excel Data as a Table */}
          {fileData.length > 0 && (
            <div className="mt-4">
              <h3 className="text-lg font-semibold">Uploaded Excel Data</h3>
              <table className="table-auto border-collapse border border-gray-300 w-full mt-2">
                <thead>
                  <tr>
                    {Object.keys(fileData[0]).map((key, idx) => (
                      <th key={idx} className="border border-gray-300 px-2 py-1">
                        {key}
                      </th>
                    ))}
                  </tr>
                </thead>
                <tbody>
                  {fileData.map((row, rowIndex) => (
                    <tr key={rowIndex}>
                      {Object.values(row).map((val, colIndex) => (
                        <td key={colIndex} className="border border-gray-300 px-2 py-1">
                          {val}
                        </td>
                      ))}
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          )}
        </CardContent>
        <CardFooter className="justify-between">
          <small>Don't have an account?</small>
          <Button asChild variant="outline" size="sm">
            <Link href="/sign-up">Sign up</Link>
          </Button>
        </CardFooter>
      </Card>
    </>
  );
}