"use client";

import { useRouter } from "next/router";
import { useEffect, useMemo, useState } from "react";

export default function DownloadPage() {
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

  const [data, setData] = useState<any>(null);

  useEffect(() => {
    if (!id) return;

    (async () => {
      // example logic
      setData({ id });
    })();
  }, [id]);

  if (!id) return <p>Loading...</p>;

  return (
    <div style={{ padding: 20 }}>
      <h1>Download</h1>
      <p>ID: {id}</p>
    </div>
  );
}
