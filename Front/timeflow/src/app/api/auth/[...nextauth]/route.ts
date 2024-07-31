import NextAuth from "next-auth";
import GitHubProvider from "next-auth/providers/github";
import CredentialsProvider from "next-auth/providers/credentials";

const handler = NextAuth({
    pages: {
        signIn: "/",
    },
    providers: [
        GitHubProvider({
            clientId: process.env.GITHUB_ID ?? "",
            clientSecret: process.env.GITHUB_SECRET ?? ""
          }),
          CredentialsProvider({
            name: "Credentials",
            
            credentials: {
              email: { label: "email", type: "email", placeholder: "Digite seu Email.." },
              password: { label: "Password", type: "password" }
            },
            async authorize(credentials, req) {
                if(!credentials){
                    return null
                }
                if (credentials.email === "icroliveira3266@gmail.com" && credentials.password === "123"){
                    
                    return{
                        id: "1",
                        name:"Icaro",
                        email:"icroliveira3266@gmail.com"
                    }
                }
                    return null;
            },
          }),
    ],
});

export { handler as GET, handler as POST}