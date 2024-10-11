import React from "react";
import MenuItem from "./menu-item";
import MenuTitle from "./menu-title";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"; // Composant Avatar de Shadcn

const MainMenu = () => {
  return (
    <nav className="bg-muted p-4 flex flex-col">
      <MenuTitle />
      <ul className="py-4 space-y-2">
        <MenuItem
          href="/ui-forms"
          submenu={[
            { children: "Submenu 1", href: "/submenu1" },
            {
              children: "Submenu 2",
              submenu: [{ children: "Subsubmenu 1", href: "/subsubmenu1" }],
            },
          ]}
        >
          My Forms
        </MenuItem>
        <MenuItem href="/ui-forms/equity">Equity Forms</MenuItem>
        <MenuItem href="/ui-forms/cty">CTY Forms</MenuItem>
        <MenuItem href="/ui-forms/settings">Settings</MenuItem>
      </ul>

      <footer className="flex items-center space-x-4">
        <Avatar>
          <AvatarImage src="/path-to-avatar.jpg" alt="User Avatar" />
          <AvatarFallback>AC</AvatarFallback>
        </Avatar>
        <Link href="/logout" className="underline">
          Logout
        </Link>
      </footer>
    </nav>
  );
};

export default MainMenu;

/*
ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

li {
  position: relative;
}

ul ul {
  margin-left: 1rem; /* Indentation pour les sous-menus */
  margin-top: 0.5rem;
}

li > ul {
  display: none; /* Masquer les sous-menus par défaut */
}

li:hover > ul, li button:focus + ul, li a:focus + ul {
  display: block; /* Afficher les sous-menus au survol ou au clic */
}
*/