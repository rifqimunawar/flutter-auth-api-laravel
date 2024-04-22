import React from "react";
import NavbarComponent from "../components/NavbarComponent";
import { Metadata } from "next";

type Props = {};

export const metadata: Metadata = {
    title: "About | MumuyStore",
};
export default function page({}: Props) {
    return (
        <section>
            <NavbarComponent />
            <h2>about</h2>
        </section>
    );
}
