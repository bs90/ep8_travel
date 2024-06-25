"use client";

import { SessionProvider } from "next-auth/react";
import { ReactNode } from "react";

export const AuthProvider = ({
  children,
  session,
}: {
  session: any;
  children: ReactNode;
}) => {
  return <SessionProvider session={session}>{children}</SessionProvider>;
};
