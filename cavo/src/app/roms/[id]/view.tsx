"use client";

import Link from "next/link";
import { useRouter } from "next/router";
import { useEffect, useMemo, useState } from "react";
import { supabase } from "@/lib/supabaseClient";
import { Section } from "@/components/Section";

type Rom = {
  id: string;
  name?: string;
  version?: string;
  notes?: string;
  url?: string;
};

export default function RomView() {
  const router = useRouter();

  const id = useMemo(() => {
    const raw = router.query?.id;
    if (typeof raw !== "string") return null;
    try {
      return decodeURIComponent(raw);
    } catch {
      return raw;
    }
  }, [router.query?.id]);

  const [item, setItem] = useState<Rom | null>(null);

  useEffect(() => {
    if (!id) return;

    (async () => {
      const { data, error } = await supabase
        .from("roms")
        .select("*")
        .eq("id", id)
        .maybeSingle();

      if (error) {
        setItem(null);
        return;
      }
      setItem((data as any) ?? null);
    })();
  }, [id]);

  if (!id) return <p>Loading...</p>;
  if (!item) return <p>Loading...</p>;

  return (
    <div>
      <h1 style={{ marginTop: 0 }}>
        {item.name ?? "ROM"}{" "}
        {item.version ? <span style={{ opacity: 0.6 }}>({item.version})</span> : null}
      </h1>

      {item.url ? (
        <p>
          <a href={item.url} target="_blank" rel="noreferrer">
            Download link
          </a>
        </p>
      ) : (
        <p style={{ opacity: 0.7 }}>No download link.</p>
      )}

      <Section title="Notes">
        <pre style={{ margin: 0, whiteSpace: "pre-wrap" }}>
          {item.notes ?? ""}
        </pre>
      </Section>

      <p style={{ marginTop: 16 }}>
        <Link href="/roms">← Back to ROMs</Link>
      </p>
    </div>
  );
}
