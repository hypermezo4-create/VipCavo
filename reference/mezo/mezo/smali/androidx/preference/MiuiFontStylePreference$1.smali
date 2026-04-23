# classes10.dex

.class Landroidx/preference/MiuiFontStylePreference$1;
.super Ljava/lang/Object;
.source "MiuiFontStylePreference.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/MiuiFontStylePreference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/MiuiFontStylePreference;


# direct methods
.method constructor <init>(Landroidx/preference/MiuiFontStylePreference;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/MiuiFontStylePreference$1;->this$0:Landroidx/preference/MiuiFontStylePreference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .registers 2

    iget-object v0, p0, Landroidx/preference/MiuiFontStylePreference$1;->this$0:Landroidx/preference/MiuiFontStylePreference;

    invoke-virtual {v0}, Landroidx/preference/MiuiFontStylePreference;->setSummary()V

    return-void
.end method
