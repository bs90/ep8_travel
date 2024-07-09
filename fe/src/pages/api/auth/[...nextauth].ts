import NextAuth from "next-auth";
import GoogleProvider from "next-auth/providers/google";
export const authOptions = {
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_OAUTH_ID || "",
      clientSecret: process.env.GOOGLE_OAUTH_SECRET || "",
    }),
  ],
  pages: {
    signIn: "/signIn", // Ensure these paths are correct
    signOut: "/signOut",
    error: "/api/auth/error", // Path to your custom error page
    verifyRequest: "/auth/verify-request",
  },
  debug: true,
};
export default NextAuth(authOptions);
