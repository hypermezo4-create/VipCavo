# classes10.dex

.class Landroidx/preference/XMiuiStarPictureSelectionPreference$1;
.super Ljava/lang/Object;
.source "XMiuiStarPictureSelectionPreference.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/XMiuiStarPictureSelectionPreference;->setPreviewPicture()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/XMiuiStarPictureSelectionPreference;


# direct methods
.method constructor <init>(Landroidx/preference/XMiuiStarPictureSelectionPreference;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference$1;->this$0:Landroidx/preference/XMiuiStarPictureSelectionPreference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 12

    iget-object v3, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference$1;->this$0:Landroidx/preference/XMiuiStarPictureSelectionPreference;

    invoke-static {v3}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->access$000(Landroidx/preference/XMiuiStarPictureSelectionPreference;)Landroid/content/Context;

    move-result-object v3

    const-string/jumbo v4, "window"

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Landroid/view/WindowManager;

    invoke-static {}, Landroid/Utils/Utils;->getRealHeight()I

    move-result v7

    invoke-static {}, Landroid/Utils/Utils;->getRealWidth()I

    move-result v9

    invoke-static {v7, v9}, Ljava/lang/Math;->min(II)I

    move-result v1

    mul-int/lit8 v3, v1, 0x2

    div-int/lit8 v1, v3, 0x3

    const/4 v2, -0x1

    iget-object v3, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference$1;->this$0:Landroidx/preference/XMiuiStarPictureSelectionPreference;

    invoke-static {v3}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->access$100(Landroidx/preference/XMiuiStarPictureSelectionPreference;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v3

    iget-object v4, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference$1;->this$0:Landroidx/preference/XMiuiStarPictureSelectionPreference;

    invoke-static {v4}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->access$100(Landroidx/preference/XMiuiStarPictureSelectionPreference;)Landroid/graphics/drawable/Drawable;

    move-result-object v4

    invoke-virtual {v4}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v4

    if-ge v3, v4, :cond_3d

    if-ge v7, v9, :cond_3d

    mul-int/lit8 v3, v7, 0x2

    div-int/lit8 v2, v3, 0x3

    const/4 v1, -0x1

    :cond_3d
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    const/16 v3, 0x3e8

    const/16 v4, 0x102

    const/4 v5, -0x3

    invoke-direct/range {v0 .. v5}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    const/high16 v3, 0x3f400000  # 0.75f

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->dimAmount:F

    const/16 v3, 0x11

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    new-instance v6, Landroid/widget/ImageView;

    iget-object v3, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference$1;->this$0:Landroidx/preference/XMiuiStarPictureSelectionPreference;

    invoke-static {v3}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->access$000(Landroidx/preference/XMiuiStarPictureSelectionPreference;)Landroid/content/Context;

    move-result-object v3

    invoke-direct {v6, v3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iget-object v3, p0, Landroidx/preference/XMiuiStarPictureSelectionPreference$1;->this$0:Landroidx/preference/XMiuiStarPictureSelectionPreference;

    invoke-static {v3}, Landroidx/preference/XMiuiStarPictureSelectionPreference;->access$100(Landroidx/preference/XMiuiStarPictureSelectionPreference;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v6, v3}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    new-instance v3, Landroidx/preference/XMiuiStarPictureSelectionPreference$1$1;

    invoke-direct {v3, p0, v8, v6}, Landroidx/preference/XMiuiStarPictureSelectionPreference$1$1;-><init>(Landroidx/preference/XMiuiStarPictureSelectionPreference$1;Landroid/view/WindowManager;Landroid/widget/ImageView;)V

    invoke-virtual {v6, v3}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-interface {v8, v6, v0}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    return-void
.end method
