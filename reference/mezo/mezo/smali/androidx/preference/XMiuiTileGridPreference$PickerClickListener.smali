# classes10.dex

.class public Landroidx/preference/XMiuiTileGridPreference$PickerClickListener;
.super Ljava/lang/Object;
.source "XMiuiTileGridPreference.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# instance fields
.field private final pref:Landroidx/preference/XMiuiTileGridPreference;

.field private final slotIndex:I


# direct methods
.method public constructor <init>(Landroidx/preference/XMiuiTileGridPreference;I)V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/preference/XMiuiTileGridPreference$PickerClickListener;->pref:Landroidx/preference/XMiuiTileGridPreference;

    iput p2, p0, Landroidx/preference/XMiuiTileGridPreference$PickerClickListener;->slotIndex:I

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 16

    iget-object v0, p0, Landroidx/preference/XMiuiTileGridPreference$PickerClickListener;->pref:Landroidx/preference/XMiuiTileGridPreference;

    invoke-static {v0}, Landroidx/preference/XMiuiTileGridPreference;->access$300(Landroidx/preference/XMiuiTileGridPreference;)[Ljava/lang/String;

    move-result-object v1

    invoke-static {v0}, Landroidx/preference/XMiuiTileGridPreference;->access$500(Landroidx/preference/XMiuiTileGridPreference;)[Ljava/lang/String;

    move-result-object v2

    aget-object v3, v2, p2

    if-eqz v3, :cond_9b

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    if-nez v4, :cond_37

    iget v5, p0, Landroidx/preference/XMiuiTileGridPreference$PickerClickListener;->slotIndex:I

    const/4 v6, 0x2

    if-lt v5, v6, :cond_9b

    const-string v7, ""

    and-int/lit8 v6, v5, -0x2

    add-int/lit8 v8, v6, 0x1

    aput-object v7, v1, v6

    aput-object v7, v1, v8

    invoke-static {v0, v6}, Landroidx/preference/XMiuiTileGridPreference;->access$100(Landroidx/preference/XMiuiTileGridPreference;I)V

    invoke-static {v0, v8}, Landroidx/preference/XMiuiTileGridPreference;->access$100(Landroidx/preference/XMiuiTileGridPreference;I)V

    goto :goto_9b

    const/4 v6, 0x4

    aput-object v7, v1, v6

    const/4 v8, 0x5

    aput-object v7, v1, v8

    invoke-static {v0, v6}, Landroidx/preference/XMiuiTileGridPreference;->access$100(Landroidx/preference/XMiuiTileGridPreference;I)V

    invoke-static {v0, v8}, Landroidx/preference/XMiuiTileGridPreference;->access$100(Landroidx/preference/XMiuiTileGridPreference;I)V

    goto :goto_9b

    :cond_37
    iget v5, p0, Landroidx/preference/XMiuiTileGridPreference$PickerClickListener;->slotIndex:I

    aget-object v6, v1, v5

    const/4 v7, 0x0

    :goto_3c
    invoke-static {v0}, Landroidx/preference/XMiuiTileGridPreference;->access$710(Landroidx/preference/XMiuiTileGridPreference;)I

    move-result v8

    if-ge v7, v8, :cond_96

    if-eq v7, v5, :cond_93

    aget-object v8, v1, v7

    if-eqz v8, :cond_93

    invoke-virtual {v3, v8}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-eqz v9, :cond_93

    invoke-static {v6}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v10

    if-eqz v10, :cond_88

    const/4 v11, 0x2

    if-lt v5, v11, :cond_88

    if-ge v7, v11, :cond_88

    invoke-static {v0}, Landroidx/preference/XMiuiTileGridPreference;->access$400(Landroidx/preference/XMiuiTileGridPreference;)[Ljava/lang/String;

    move-result-object v12

    array-length v11, v12

    const/4 v4, 0x0

    :goto_5f
    if-ge v4, v11, :cond_9b

    aget-object v8, v12, v4

    invoke-static {v8}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v9

    if-nez v9, :cond_85

    const/4 v7, 0x0

    invoke-static {v0}, Landroidx/preference/XMiuiTileGridPreference;->access$710(Landroidx/preference/XMiuiTileGridPreference;)I

    move-result v6

    :goto_6e
    if-ge v7, v6, :cond_7f

    if-eq v7, v5, :cond_7c

    aget-object v10, v1, v7

    if-eqz v10, :cond_7c

    invoke-virtual {v8, v10}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v9

    if-nez v9, :cond_85

    :cond_7c
    add-int/lit8 v7, v7, 0x1

    goto :goto_6e

    :cond_7f
    aput-object v8, v1, v5

    invoke-static {v0, v5}, Landroidx/preference/XMiuiTileGridPreference;->access$100(Landroidx/preference/XMiuiTileGridPreference;I)V

    goto :goto_9b

    :cond_85
    add-int/lit8 v4, v4, 0x1

    goto :goto_5f

    :cond_88
    aput-object v3, v1, v5

    aput-object v6, v1, v7

    invoke-static {v0, v5}, Landroidx/preference/XMiuiTileGridPreference;->access$100(Landroidx/preference/XMiuiTileGridPreference;I)V

    invoke-static {v0, v7}, Landroidx/preference/XMiuiTileGridPreference;->access$100(Landroidx/preference/XMiuiTileGridPreference;I)V

    goto :goto_9b

    :cond_93
    add-int/lit8 v7, v7, 0x1

    goto :goto_3c

    :cond_96
    aput-object v3, v1, v5

    invoke-static {v0, v5}, Landroidx/preference/XMiuiTileGridPreference;->access$100(Landroidx/preference/XMiuiTileGridPreference;I)V

    :cond_9b
    :goto_9b
    invoke-static {v0}, Landroidx/preference/XMiuiTileGridPreference;->access$200(Landroidx/preference/XMiuiTileGridPreference;)V

    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    return-void
.end method
