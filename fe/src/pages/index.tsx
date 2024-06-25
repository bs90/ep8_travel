import { redirect } from "next/navigation";
import { HomePage } from "../components/templates/HomePage";
import { useSession } from "next-auth/react";

export default function Home() {
  const session = useSession();

  if (!session) {
    redirect("/signIn");
  }
  return (
    <main>
      <HomePage />
    </main>
  );
}
