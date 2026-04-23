# classes10.dex

.class public Landroidx/preference/XMiuiTileGridPreference$SaveClickListener;
.super Ljava/lang/Object;
.source "XMiuiTileGridPreference.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# instance fields
.field private final pref:Landroidx/preference/XMiuiTileGridPreference;


# direct methods
.method public constructor <init>(Landroidx/preference/XMiuiTileGridPreference;)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/preference/XMiuiTileGridPreference$SaveClickListener;->pref:Landroidx/preference/XMiuiTileGridPreference;

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference$SaveClickListener;->pref:Landroidx/preference/XMiuiTileGridPreference;

    invoke-static {v0}, Landroidx/preference/XMiuiTileGridPreference;->access$200(Landroidx/preference/XMiuiTileGridPreference;)V

    return-void
.end method
