import Image from "next/image";
import HomePage from "./home/page";
import { Metadata } from "next";

export const metadata: Metadata = {
    title: "Home",
};
export default function Home() {
    return (
        <>
            <HomePage />
        </>
    );
}
