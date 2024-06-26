"use client";

import { useSession } from "next-auth/react";
import { redirect } from "next/navigation";
import { SignIn } from "../../components/templates/Signin";
import RootLayout from "../layout";

export default function SignInPage() {
  const session = useSession();

  if (session?.data?.user) {
    redirect("/");
  }

  return (
    <RootLayout>
      <SignIn />
    </RootLayout>
  );
}
