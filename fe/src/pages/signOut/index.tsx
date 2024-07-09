import React, { useEffect } from "react";
import { signOut } from "next-auth/react";

const SignOutPage = () => {
  useEffect(() => {
    signOut({ callbackUrl: "/" });
  }, []);

  return (
    <div>
      <h1>Signing you out...</h1>
    </div>
  );
};

export default SignOutPage;
