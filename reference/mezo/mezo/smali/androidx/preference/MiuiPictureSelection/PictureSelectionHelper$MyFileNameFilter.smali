# classes10.dex

.class Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper$MyFileNameFilter;
.super Ljava/lang/Object;
.source "PictureSelectionHelper.java"

# interfaces
.implements Ljava/io/FilenameFilter;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "MyFileNameFilter"
.end annotation


# instance fields
.field private ext:Ljava/lang/String;


# direct methods
.method private constructor <init>(Ljava/lang/String;)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper$MyFileNameFilter;->ext:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Ljava/lang/String;Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper$1;)V
    .registers 3

    invoke-direct {p0, p1}, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper$MyFileNameFilter;-><init>(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public accept(Ljava/io/File;Ljava/lang/String;)Z
    .registers 4

    iget-object v0, p0, Landroidx/preference/MiuiPictureSelection/PictureSelectionHelper$MyFileNameFilter;->ext:Ljava/lang/String;

    invoke-virtual {p2, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method
