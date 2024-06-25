// import { Container } from "../components/atoms/container";
import { HomePage } from "../components/templates/HomePage";
import RootLayout from "./layout";

export default function Home() {
  return (
    <main>
      <RootLayout>
        <HomePage />
      </RootLayout>
    </main>
  );
}
