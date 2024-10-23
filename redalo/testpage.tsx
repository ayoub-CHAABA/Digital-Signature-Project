import React from 'react';
import { useForm } from 'react-hook-form';
import Card from './Card'; // Votre composant Card personnalisé
import Form from './Form'; // Votre composant Form personnalisé
import { FormField, FormItem, FormLabel, FormControl, FormMessage, Input, Select, SelectItem, SelectTrigger, SelectValue, SelectContent } from "@/components/ui/form"; // Shadcn form components

export default function ExampleForm() {
  const form = useForm({
    defaultValues: {
      email: "",
      cA: "",
      accountType: "",
    },
  });

  const handleSubmit = (data: any) => {
    console.log("Submitted:", data);
  };

  return (
    <Card title="Transfer" description="Transfer validation">
      <Form form={form} onSubmit={handleSubmit}>
        {/* Champs du formulaire */}
        <FormField
          control={form.control}
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Email</FormLabel>
              <FormControl>
                <Input placeholder="john.doe@example.com" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="cA"
          render={({ field }) => (
            <FormItem>
              <FormLabel>CalA</FormLabel>
              <Select onValueChange={field.onChange} value={field.value}>
                <FormControl>
                  <SelectTrigger>
                    <SelectValue placeholder="Select a ca" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  <SelectItem value="S">S</SelectItem>
                  <SelectItem value="P">P</SelectItem>
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="accountType"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Data Source</FormLabel>
              <Select onValueChange={field.onChange} value={field.value}>
                <FormControl>
                  <SelectTrigger>
                    <SelectValue placeholder="Select an account type" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  <SelectItem value="S">S</SelectItem>
                  <SelectItem value="P">P</SelectItem>
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />

        <Button type="submit">Submit</Button>
      </Form>
    </Card>
  );
}