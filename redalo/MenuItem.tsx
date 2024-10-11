import React, { useState } from "react";
import Link from "next/link";
import { cn } from "@/lib/utils"; // Utility function from Shadcn for handling class names
import { ChevronDownIcon } from "@heroicons/react/outline"; // Example icon from Heroicons (Shadcn compatible)

type MenuItemProps = {
  children: React.ReactNode;
  href?: string;
  submenu?: MenuItemProps[];
};

const MenuItem = ({ children, href, submenu }: MenuItemProps) => {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <li className="relative group">
      {href ? (
        <Link href={href} className={cn(
          "flex justify-between items-center p-2 hover:bg-muted rounded-lg text-muted-foreground hover:text-foreground",
          submenu && "pr-4"
        )}>
          {children}
          {submenu && <ChevronDownIcon className="h-4 w-4 ml-2" />}
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
          {submenu && <ChevronDownIcon className="h-4 w-4 ml-2" />}
        </button>
      )}

      {/* Submenu Rendering */}
      {submenu && (
        <ul
          className={cn(
            "pl-4 space-y-2 mt-1 transition-all ease-in-out duration-300",
            isOpen ? "block" : "hidden",
            "absolute left-full top-0 w-48 bg-white shadow-lg rounded-lg z-10 group-hover:block"
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