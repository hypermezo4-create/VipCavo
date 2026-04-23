# classes10.dex

.class public Landroidx/preference/XMiuiTileGridPreference$TileClickListener;
.super Ljava/lang/Object;
.source "XMiuiTileGridPreference.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private final pref:Landroidx/preference/XMiuiTileGridPreference;


# direct methods
.method public constructor <init>(Landroidx/preference/XMiuiTileGridPreference;)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/preference/XMiuiTileGridPreference$TileClickListener;->pref:Landroidx/preference/XMiuiTileGridPreference;

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 5

    if-eqz p1, :cond_15

    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v0

    instance-of v1, v0, Ljava/lang/Integer;

    if-eqz v1, :cond_15

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v2

    iget-object p0, p0, Landroidx/preference/XMiuiTileGridPreference$TileClickListener;->pref:Landroidx/preference/XMiuiTileGridPreference;

    invoke-static {p0, v2}, Landroidx/preference/XMiuiTileGridPreference;->access$000(Landroidx/preference/XMiuiTileGridPreference;I)V

    :cond_15
    return-void
.end method
