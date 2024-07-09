// pages/api/auth/error.js

export default function handler(
  req: { method: string },
  res: {
    status: (arg0: number) => {
      (): any;
      new (): any;
      json: { (arg0: { message: string }): void; new (): any };
    };
  }
) {
  if (req.method === "GET") {
    res.status(200).json({ message: "This is the auth error page" });
  } else {
    res.status(405).json({ message: "Method Not Allowed" });
  }
}
