# classes10.dex

.class final Landroidx/preference/XMiuiSeekBarPreference$SavedState$1;
.super Ljava/lang/Object;
.source "XMiuiSeekBarPreference.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preference/XMiuiSeekBarPreference$SavedState;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator",
        "<",
        "Landroidx/preference/XMiuiSeekBarPreference$SavedState;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Landroidx/preference/XMiuiSeekBarPreference$SavedState;
    .registers 3

    new-instance v0, Landroidx/preference/XMiuiSeekBarPreference$SavedState;

    invoke-direct {v0, p1}, Landroidx/preference/XMiuiSeekBarPreference$SavedState;-><init>(Landroid/os/Parcel;)V

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .registers 3

    invoke-virtual {p0, p1}, Landroidx/preference/XMiuiSeekBarPreference$SavedState$1;->createFromParcel(Landroid/os/Parcel;)Landroidx/preference/XMiuiSeekBarPreference$SavedState;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Landroidx/preference/XMiuiSeekBarPreference$SavedState;
    .registers 3

    new-array v0, p1, [Landroidx/preference/XMiuiSeekBarPreference$SavedState;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .registers 3

    invoke-virtual {p0, p1}, Landroidx/preference/XMiuiSeekBarPreference$SavedState$1;->newArray(I)[Landroidx/preference/XMiuiSeekBarPreference$SavedState;

    move-result-object v0

    return-object v0
.end method
