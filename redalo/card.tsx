import React from 'react';
import { Card as ShadcnCard, CardContent, CardHeader, CardTitle, CardDescription } from "@/components/ui/card"; // Importation des composants Card de Shadcn

type CardProps = {
  title: string;
  description: string;
  children: React.ReactNode; // Pour injecter les composants enfants via les props
};

const Card = ({ title, description, children }: CardProps) => {
  return (
    <ShadcnCard className="w-full text-center">
      <CardHeader>
        <CardTitle>{title}</CardTitle>
        <CardDescription>{description}</CardDescription>
      </CardHeader>
      <CardContent>
        {children} {/* Affiche les composants enfants */}
      </CardContent>
    </ShadcnCard>
  );
};

export default Card;