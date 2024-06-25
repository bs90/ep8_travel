import "@/styles/globals.css";
import type { AppProps } from "next/app";
import RootLayout from "./layout";

export default function App({ Component, pageProps }: AppProps) {
  return (
    <RootLayout session={pageProps.session}>
      <Component {...pageProps} />
    </RootLayout>
  );
}
