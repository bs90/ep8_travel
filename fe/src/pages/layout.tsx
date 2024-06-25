"use client";
import { AuthProvider } from "../components/molecules/authProvider";
import { Container } from "../components/atoms/container";
import { Footer } from "../components/organisms/Footer";
import { Navbar } from "../components/organisms/Navbar";
import { ThemeProvider } from "../components/organisms/ThemeProvider";

export default function RootLayout({
  children,
}: {
  // eslint-disable-next-line no-undef
  children: React.ReactNode;
}) {
  return (
    <Container>
      <AuthProvider>
        <ThemeProvider attribute="class" defaultTheme="light">
          <Navbar />
          {children}
          {/* <Toaster /> */}
        </ThemeProvider>
      </AuthProvider>
      <Footer />
    </Container>
  );
}
