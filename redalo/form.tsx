import React from 'react';
import { Form as ShadcnForm } from "@/components/ui/form";
import { UseFormReturn } from "react-hook-form";
import { FormField, FormItem, FormLabel, FormControl, FormMessage, Input } from "@/components/ui/form";
import SelectField from './SelectField'; // Import du composant SelectField

// Interface pour décrire un champ de formulaire
type FormFieldProps = {
  name: string;
  label: string;
  placeholder: string;
  type: 'text' | 'select'; // Supporte les types de champ 'text' et 'select'
  options?: { value: string, label: string }[]; // Pour les options du Select
};

// Props du composant Formulaire
type FormProps = {
  form: UseFormReturn<any>;
  onSubmit: (data: any) => void;
  fields: FormFieldProps[]; // Les champs du formulaire sont injectés via cette prop
};

const Form = ({ form, onSubmit, fields }: FormProps) => {
  return (
    <ShadcnForm {...form}>
      <form
        className="flex flex-col gap-4"
        onSubmit={form.handleSubmit(onSubmit)}
      >
        {fields.map((field) => (
          <FormField
            key={field.name}
            control={form.control}
            name={field.name}
            render={({ field: formField }) => (
              <FormItem>
                <FormLabel>{field.label}</FormLabel>
                <FormControl>
                  {field.type === 'text' && (
                    <Input placeholder={field.placeholder} {...formField} />
                  )}
                  {field.type === 'select' && (
                    <SelectField
                      value={formField.value}
                      onChange={formField.onChange}
                      placeholder={field.placeholder}
                      options={field.options || []} // Les options sont passées via les props
                    />
                  )}
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
        ))}
      </form>
    </ShadcnForm>
  );
};

export default Form;