# classes10.dex

.class Landroidx/preference/XMiuiPictureSelectionPreference$2;
.super Ljava/lang/Object;
.source "XMiuiPictureSelectionPreference.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/XMiuiPictureSelectionPreference;->setPreviewPicture()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/XMiuiPictureSelectionPreference;


# direct methods
.method constructor <init>(Landroidx/preference/XMiuiPictureSelectionPreference;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/XMiuiPictureSelectionPreference$2;->this$0:Landroidx/preference/XMiuiPictureSelectionPreference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 16

    const/4 v9, 0x1

    iget-object v3, p0, Landroidx/preference/XMiuiPictureSelectionPreference$2;->this$0:Landroidx/preference/XMiuiPictureSelectionPreference;

    invoke-static {v3}, Landroidx/preference/XMiuiPictureSelectionPreference;->access$100(Landroidx/preference/XMiuiPictureSelectionPreference;)Landroid/content/Context;

    move-result-object v3

    const-string v4, "window"

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Landroid/view/WindowManager;

    invoke-static {}, Landroid/Utils/Utils;->getRealHeight()I

    move-result v11

    invoke-static {}, Landroid/Utils/Utils;->getRealWidth()I

    move-result v13

    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v3

    iget v3, v3, Landroid/content/res/Configuration;->orientation:I

    if-ne v3, v9, :cond_91

    :goto_23
    if-eqz v9, :cond_93

    move v1, v13

    :goto_26
    mul-int/lit8 v3, v1, 0x2

    div-int/lit8 v1, v3, 0x3

    if-nez v9, :cond_95

    move v2, v13

    :goto_2d
    mul-int/lit8 v3, v2, 0x2

    div-int/lit8 v2, v3, 0x3

    iget-object v3, p0, Landroidx/preference/XMiuiPictureSelectionPreference$2;->this$0:Landroidx/preference/XMiuiPictureSelectionPreference;

    invoke-static {v3}, Landroidx/preference/XMiuiPictureSelectionPreference;->access$200(Landroidx/preference/XMiuiPictureSelectionPreference;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v3

    int-to-float v8, v3

    iget-object v3, p0, Landroidx/preference/XMiuiPictureSelectionPreference$2;->this$0:Landroidx/preference/XMiuiPictureSelectionPreference;

    invoke-static {v3}, Landroidx/preference/XMiuiPictureSelectionPreference;->access$200(Landroidx/preference/XMiuiPictureSelectionPreference;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v3}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v3

    int-to-float v7, v3

    div-float v10, v7, v8

    if-eqz v9, :cond_97

    int-to-float v3, v1

    mul-float/2addr v3, v10

    float-to-int v2, v3

    :goto_4e
    new-instance v0, Landroid/view/WindowManager$LayoutParams;

    const/16 v3, 0x3e8

    const/16 v4, 0x102

    const/4 v5, -0x3

    invoke-direct/range {v0 .. v5}, Landroid/view/WindowManager$LayoutParams;-><init>(IIIII)V

    const/high16 v3, 0x3f400000  # 0.75f

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->dimAmount:F

    const/16 v3, 0x11

    iput v3, v0, Landroid/view/WindowManager$LayoutParams;->gravity:I

    new-instance v3, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;

    iget-object v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference$2;->this$0:Landroidx/preference/XMiuiPictureSelectionPreference;

    invoke-static {v4}, Landroidx/preference/XMiuiPictureSelectionPreference;->access$100(Landroidx/preference/XMiuiPictureSelectionPreference;)Landroid/content/Context;

    move-result-object v4

    invoke-direct {v3, v4}, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;-><init>(Landroid/content/Context;)V

    const/16 v4, 0x2d

    invoke-virtual {v3, v4}, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->setRadius(I)Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;

    move-result-object v6

    new-instance v3, Landroidx/preference/XMiuiPictureSelectionPreference$2$1;

    invoke-direct {v3, p0, v12, v6}, Landroidx/preference/XMiuiPictureSelectionPreference$2$1;-><init>(Landroidx/preference/XMiuiPictureSelectionPreference$2;Landroid/view/WindowManager;Landroid/widget/ImageView;)V

    invoke-virtual {v6, v3}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    new-instance v3, Landroidx/preference/XMiuiPictureSelectionPreference$2$2;

    invoke-direct {v3, p0, v12, v6}, Landroidx/preference/XMiuiPictureSelectionPreference$2$2;-><init>(Landroidx/preference/XMiuiPictureSelectionPreference$2;Landroid/view/WindowManager;Landroid/widget/ImageView;)V

    invoke-virtual {v6, v3}, Landroid/widget/ImageView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    invoke-interface {v12, v6, v0}, Landroid/view/WindowManager;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v3, p0, Landroidx/preference/XMiuiPictureSelectionPreference$2;->this$0:Landroidx/preference/XMiuiPictureSelectionPreference;

    invoke-static {v3}, Landroidx/preference/XMiuiPictureSelectionPreference;->access$200(Landroidx/preference/XMiuiPictureSelectionPreference;)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v6, v3}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v6}, Landroid/widget/ImageView;->postInvalidate()V

    return-void

    :cond_91
    const/4 v9, 0x0

    goto :goto_23

    :cond_93
    move v1, v11

    goto :goto_26

    :cond_95
    move v2, v11

    goto :goto_2d

    :cond_97
    int-to-float v3, v2

    div-float/2addr v3, v10

    float-to-int v1, v3

    goto :goto_4e
.end method
