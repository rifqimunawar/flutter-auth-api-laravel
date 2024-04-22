import { Metadata } from "next";
import React from "react";
import NavbarComponent from "../components/NavbarComponent";
import CarauselComponent from "../components/CarauselComponent";
import CategoryListComponent from "../components/CategoryListComponent";

type Props = {};

export const metadata: Metadata = {
    title: "Home | Store",
};

export default function HomePage({}: Props) {
    return (
        <section>
            <NavbarComponent />
        <CarauselComponent />
        <CategoryListComponent/>
        </section>
    );
}
