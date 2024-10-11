import React, { useState } from "react";
import Link from "next/link";
import { cn } from "@/lib/utils"; // Utilitaire pour gérer les classNames
import { ChevronDown } from "lucide-react"; // Icône Shadcn

type MenuItemProps = {
  children: React.ReactNode;
  href?: string;
  submenu?: MenuItemProps[];
};

const MenuItem = ({ children, href, submenu }: MenuItemProps) => {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <li className="relative">
      {href ? (
        <Link
          href={href}
          className={cn(
            "flex justify-between items-center p-2 hover:bg-muted rounded-lg text-muted-foreground hover:text-foreground",
            submenu && "pr-4"
          )}
          onClick={() => setIsOpen(!isOpen)}
        >
          {children}
          {submenu && <ChevronDown className="h-4 w-4 ml-2" />}
        </Link>
      ) : (
        <button
          onClick={() => setIsOpen(!isOpen)}
          className={cn(
            "flex justify-between items-center w-full p-2 hover:bg-muted rounded-lg text-muted-foreground hover:text-foreground",
            submenu && "pr-4"
          )}
        >
          {children}
          {submenu && <ChevronDown className="h-4 w-4 ml-2" />}
        </button>
      )}

      {/* Sous-menus affichés en dessous */}
      {submenu && isOpen && (
        <ul
          className={cn(
            "pl-4 space-y-2 mt-2 transition-all ease-in-out duration-300",
            isOpen ? "block" : "hidden"
          )}
        >
          {submenu.map((item, index) => (
            <MenuItem key={index} {...item} />
          ))}
        </ul>
      )}
    </li>
  );
};

export default MenuItem;