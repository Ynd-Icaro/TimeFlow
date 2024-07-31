"use client"

import { signOut } from "next-auth/react"

export default function ButtonLogout() {
  return(
    <button className="" onClick={() => signOut()}> Logout </button>
  )
};
