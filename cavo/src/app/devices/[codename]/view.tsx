"use client";

import { useRouter } from "next/router";
import { useEffect, useMemo, useState } from "react";
import { supabase } from "@/lib/supabaseClient";
import { Section } from "@/components/Section";

type Device = {
  id: string;
  name: string;
  codename: string;
  photos?: string[];
  specs?: any;
};

export default function DeviceClient() {
  const router = useRouter();

  const codename = useMemo(() => {
    const raw = router.query?.codename;
    if (typeof raw !== "string") return null;
    try {
      return decodeURIComponent(raw);
    } catch {
      return raw;
    }
  }, [router.query?.codename]);

  const [item, setItem] = useState<Device | null>(null);

  useEffect(() => {
    if (!codename) return;

    (async () => {
      const { data, error } = await supabase
        .from("devices")
        .select("*")
        .eq("codename", codename)
        .maybeSingle();

      if (error) {
        setItem(null);
        return;
      }
      setItem((data as any) ?? null);
    })();
  }, [codename]);

  if (!codename) return <p>Loading...</p>;
  if (!item) return <p>Loading...</p>;

  return (
    <div>
      <h1 style={{ marginTop: 0 }}>
        {item.name} <span style={{ opacity: 0.6 }}>({item.codename})</span>
      </h1>

      <Section title="Photos">
        {item.photos?.length ? (
          <div style={{ display: "grid", gap: 8 }}>
            {item.photos.map((u, i) => (
              <a key={i} href={u} target="_blank" rel="noreferrer">
                {u}
              </a>
            ))}
          </div>
        ) : (
          <p style={{ opacity: 0.7 }}>No photos.</p>
        )}
      </Section>

      <Section title="Specs">
        <pre style={{ margin: 0, whiteSpace: "pre-wrap" }}>
          {JSON.stringify(item.specs ?? {}, null, 2)}
        </pre>
      </Section>
    </div>
  );
}
