"use client";

import { signIn } from "next-auth/react";
import { AuthLayout } from "./AuthLayout";

export interface IRegisterProps {}

export const SignIn = () => {
  return (
    <AuthLayout title={"Login"}>
      <div className="flex flex-col items-center gap-2 my-6">
        <div className="h-[1px] bg-black/20 w-36 my-2" />
        <button
          onClick={() => {
            signIn("google", { callbackUrl: "/" });
          }}
          className="text-lg hover:shadow-lg transition-shadow flex items-center justify-center w-8 h-8 border border-[#ea4335] rounded-full"
        >
          G
        </button>
      </div>
    </AuthLayout>
  );
};
