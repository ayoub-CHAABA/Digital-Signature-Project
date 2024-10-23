import React from 'react';
import { Form as ShadcnForm } from "@/components/ui/form";
import { UseFormReturn } from "react-hook-form";

type FormProps = {
  form: UseFormReturn<any>; // Instance du formulaire provenant de `react-hook-form`
  onSubmit: (data: any) => void; // Gestionnaire de soumission
  children: React.ReactNode; // Champs du formulaire injectés via les props
};

const Form = ({ form, onSubmit, children }: FormProps) => {
  return (
    <ShadcnForm {...form}>
      <form
        className="flex flex-col gap-4"
        onSubmit={form.handleSubmit(onSubmit)}
      >
        {children} {/* Affiche les champs du formulaire */}
      </form>
    </ShadcnForm>
  );
};

export default Form;