# classes10.dex

.class public Landroidx/preference/XMiuiTileGridPreference$CountClickListener;
.super Ljava/lang/Object;
.source "XMiuiTileGridPreference.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private final delta:I

.field private final pref:Landroidx/preference/XMiuiTileGridPreference;


# direct methods
.method public constructor <init>(Landroidx/preference/XMiuiTileGridPreference;I)V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;->pref:Landroidx/preference/XMiuiTileGridPreference;

    iput p2, p0, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;->delta:I

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;->pref:Landroidx/preference/XMiuiTileGridPreference;

    iget v1, p0, Landroidx/preference/XMiuiTileGridPreference$CountClickListener;->delta:I

    invoke-static {v0, v1}, Landroidx/preference/XMiuiTileGridPreference;->access$700(Landroidx/preference/XMiuiTileGridPreference;I)V

    return-void
.end method
