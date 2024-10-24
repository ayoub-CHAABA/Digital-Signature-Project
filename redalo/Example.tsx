import React from 'react';
import { useForm } from 'react-hook-form';
import Form from './ui/form';
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

  // Les champs du formulaire sont définis ici comme des objets
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
      placeholder: 'Select a calculator agent',
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
      <Form form={form} onSubmit={handleSubmit} fields={formFields} />
      <Button type="submit" className="mt-4">Submit</Button>
    </div>
  );
}