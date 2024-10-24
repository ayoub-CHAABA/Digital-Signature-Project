import React from 'react';
import { Select, SelectTrigger, SelectValue, SelectContent, SelectItem } from '@/components/ui/select'; // Import des composants Shadcn

// Interface pour les props du Select
type SelectFieldProps = {
  value: string; // Le type de la valeur doit être "string" (si ce sont des strings dans les options)
  onChange: (value: string) => void;
  placeholder: string;
  options: { value: string; label: string }[];
};

const SelectField = ({ value, onChange, placeholder, options }: SelectFieldProps) => {
  return (
    <Select defaultValue={value} onValueChange={onChange}>
      <SelectTrigger>
        <SelectValue placeholder={placeholder} />
      </SelectTrigger>
      <SelectContent>
        {options.map((option) => (
          <SelectItem key={option.value} value={option.value}>
            {option.label}
          </SelectItem>
        ))}
      </SelectContent>
    </Select>
  );
};

export default SelectField;