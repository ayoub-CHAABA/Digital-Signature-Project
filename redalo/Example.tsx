import React from 'react';
import { useForm } from 'react-hook-form';
import Card from './ui/card'; // Your custom Card component
import Form from './ui/form'; // Your custom Form component
import { Button } from "@/components/ui/button";

export default function ExampleForm() {
  const form = useForm({
    defaultValues: {
      email: "",
      cA: "",
      accountType: "",
    },
  });

  const handleSubmit = (data: any) => {
    console.log("Form Submitted:", data);
  };

  // Define the form fields with their respective configurations
  const formFields = [
    {
      name: 'email',
      label: 'Email',
      placeholder: 'john.doe@example.com',
      type: 'text',
    },
    {
      name: 'cA',
      label: 'CA',
      placeholder: 'Select a calcul',
      type: 'select',
      options: [
        { value: 'S', label: 'S' },
        { value: 'P', label: 'P' },
      ],
    },
    {
      name: 'accountType',
      label: 'Account Type',
      placeholder: 'Select an account type',
      type: 'select',
      options: [
        { value: 'S', label: 'S' },
        { value: 'P', label: 'P' },
      ],
    },
  ];

  return (
    <div className="container mx-auto p-4">
      <Card title="Transfer" description="Transfer after validation">
        <Form form={form} onSubmit={handleSubmit} fields={formFields} />
        <Button type="submit" className="mt-4">Submit</Button>
      </Card>
    </div>
  );
}