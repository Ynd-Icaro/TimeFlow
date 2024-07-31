import { getServerSession } from "next-auth"
import ButtonLogout from "./logoutBtn";
import { redirect } from "next/navigation";
import Image from "next/image";

export default async function page() {
    const session = await getServerSession()

    if(!session){
        redirect("/")
    }

    return(
        <div>
            {session.user?.image && <div className="w-[150px]"><Image src={session.user?.image} alt="avatar" width={150} height={150}/></div>}
            <div>Olá {session?.user?.name}</div>
            <div>Dashboard</div>
            <div>
               <ButtonLogout/>
            </div>
        </div>
    );
};
