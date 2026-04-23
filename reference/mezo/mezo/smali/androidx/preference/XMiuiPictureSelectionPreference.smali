# classes10.dex

.class public Landroidx/preference/XMiuiPictureSelectionPreference;
.super Landroidx/preference/Preference;
.source "XMiuiPictureSelectionPreference.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;
    }
.end annotation


# instance fields
.field private mAspectX:I

.field private mAspectY:I

.field private final mContext:Landroid/content/Context;

.field private final mDensity:F

.field private mDrawableIcon:Landroid/graphics/drawable/Drawable;

.field private mHeight:I

.field private mIntent:Ljava/lang/String;

.field private mName:Ljava/lang/String;

.field private final mOk:Z

.field private mThumb:Z

.field private mType:I

.field private mView:Landroid/view/View;

.field private mWidth:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 4

    invoke-direct {p0, p1, p2}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    iput-object p1, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mContext:Landroid/content/Context;

    invoke-direct {p0, p2}, Landroidx/preference/XMiuiPictureSelectionPreference;->initialize(Landroid/util/AttributeSet;)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mOk:Z

    invoke-virtual {p0}, Landroidx/preference/XMiuiPictureSelectionPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    iput v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mDensity:F

    return-void
.end method

.method static synthetic access$000(Landroidx/preference/XMiuiPictureSelectionPreference;)V
    .registers 1

    invoke-direct {p0}, Landroidx/preference/XMiuiPictureSelectionPreference;->setPreviewPicture()V

    return-void
.end method

.method static synthetic access$100(Landroidx/preference/XMiuiPictureSelectionPreference;)Landroid/content/Context;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$200(Landroidx/preference/XMiuiPictureSelectionPreference;)Landroid/graphics/drawable/Drawable;
    .registers 2

    iget-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mDrawableIcon:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method static synthetic access$300(Landroidx/preference/XMiuiPictureSelectionPreference;)V
    .registers 1

    invoke-direct {p0}, Landroidx/preference/XMiuiPictureSelectionPreference;->deleteRec()V

    return-void
.end method

.method private deleteRec()V
    .registers 5

    invoke-virtual {p0}, Landroidx/preference/XMiuiPictureSelectionPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "content://miui.imagegalery.imageProvider"

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    iget-object v2, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mName:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/content/ContentResolver;->delete(Landroid/net/Uri;Ljava/lang/String;[Ljava/lang/String;)I

    return-void
.end method

.method public static getDrawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .registers 10

    const/4 v2, 0x0

    const/4 v7, 0x0

    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "content://miui.imagegalery.imageProvider"

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    move-object v3, p1

    move-object v4, v2

    move-object v5, v2

    invoke-virtual/range {v0 .. v5}, Landroid/content/ContentResolver;->query(Landroid/net/Uri;[Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)Landroid/database/Cursor;

    move-result-object v6

    if-eqz v6, :cond_36

    :goto_15
    invoke-interface {v6}, Landroid/database/Cursor;->moveToNext()Z

    move-result v0

    if-eqz v0, :cond_33

    new-instance v7, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "data"

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getColumnIndex(Ljava/lang/String;)I

    move-result v1

    invoke-interface {v6, v1}, Landroid/database/Cursor;->getBlob(I)[B

    move-result-object v1

    invoke-static {v1}, Landroid/preference/MyPictureSelectionPreference;->getImage([B)Landroid/graphics/Bitmap;

    move-result-object v1

    invoke-direct {v7, v0, v1}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    goto :goto_15

    :cond_33
    invoke-interface {v6}, Landroid/database/Cursor;->close()V

    :cond_36
    return-object v7
.end method

.method public static getDrawableFromPath(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;
    .registers 2

    invoke-static {p0}, Landroid/preference/MyPictureSelectionPreference;->getDrawableFromPath(Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v0

    return-object v0
.end method

.method private getStartIntent()Landroid/content/Intent;
    .registers 5

    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    const-string v1, "miui.imagegalery"

    const-string v2, "miui.imagegalery.ImagePickerActivity"

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->setClassName(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v1

    const-string v2, "type"

    iget v3, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mType:I

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object v1

    const-string v2, "name"

    iget-object v3, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    iget-object v1, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mIntent:Ljava/lang/String;

    if-eqz v1, :cond_27

    const-string v1, "intent"

    iget-object v2, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mIntent:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    :cond_27
    iget v1, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mType:I

    const/4 v2, 0x4

    if-ne v1, v2, :cond_4b

    const-string v1, "aspectX"

    iget v2, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mAspectX:I

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object v1

    const-string v2, "aspectY"

    iget v3, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mAspectY:I

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object v1

    const-string v2, "width"

    iget v3, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mWidth:I

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    move-result-object v1

    const-string v2, "height"

    iget v3, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mHeight:I

    invoke-virtual {v1, v2, v3}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    :cond_4b
    return-object v0
.end method

.method private getmType(Ljava/lang/String;)I
    .registers 8

    const/4 v3, 0x3

    const/4 v2, 0x2

    const/4 v1, 0x1

    const/4 v0, 0x0

    const/4 v4, -0x1

    invoke-virtual {p1}, Ljava/lang/String;->hashCode()I

    move-result v5

    sparse-switch v5, :sswitch_data_40

    :cond_c
    :goto_c
    packed-switch v4, :pswitch_data_52

    const/4 v0, 0x4

    :goto_10
    :pswitch_10  #0x0
    return v0

    :sswitch_11
    const-string v5, "portrait"

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_c

    move v4, v0

    goto :goto_c

    :sswitch_1b
    const-string v5, "landscape"

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_c

    move v4, v1

    goto :goto_c

    :sswitch_25
    const-string v5, "square"

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_c

    move v4, v2

    goto :goto_c

    :sswitch_2f
    const-string v5, "not_defined"

    invoke-virtual {p1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_c

    move v4, v3

    goto :goto_c

    :pswitch_39  #0x1
    move v0, v1

    goto :goto_10

    :pswitch_3b  #0x2
    move v0, v2

    goto :goto_10

    :pswitch_3d  #0x3
    move v0, v3

    goto :goto_10

    nop

    :sswitch_data_40
    .sparse-switch
        -0x3553a6e3 -> :sswitch_25
        -0x239d363 -> :sswitch_2f
        0x2b77bb9b -> :sswitch_11
        0x5545f2bb -> :sswitch_1b
    .end sparse-switch

    :pswitch_data_52
    .packed-switch 0x0
        :pswitch_10  #00000000
        :pswitch_39  #00000001
        :pswitch_3b  #00000002
        :pswitch_3d  #00000003
    .end packed-switch
.end method

.method private initialize(Landroid/util/AttributeSet;)Z
    .registers 8

    const/4 v3, 0x1

    const/4 v2, 0x0

    new-instance v0, Landroidx/preference/XMiuiPreferenceHelper;

    iget-object v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mContext:Landroid/content/Context;

    invoke-direct {v0, v4, p1}, Landroidx/preference/XMiuiPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const-string v4, "name"

    invoke-virtual {v0, v4}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mName:Ljava/lang/String;

    if-nez v4, :cond_14

    :cond_13
    :goto_13
    return v2

    :cond_14
    const-string v4, "thumbnail"

    invoke-virtual {v0, v4, v3}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeBool(Ljava/lang/String;Z)Z

    move-result v4

    iput-boolean v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mThumb:Z

    iget-object v4, v0, Landroidx/preference/XMiuiPreferenceHelper;->mIntent:Ljava/lang/String;

    iput-object v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mIntent:Ljava/lang/String;

    const-string v4, "type"

    invoke-virtual {v0, v4}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_2a

    const-string v1, ""

    :cond_2a
    invoke-virtual {v1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Landroidx/preference/XMiuiPictureSelectionPreference;->getmType(Ljava/lang/String;)I

    move-result v4

    iput v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mType:I

    iget v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mType:I

    const/4 v5, 0x4

    if-eq v4, v5, :cond_3b

    move v2, v3

    goto :goto_13

    :cond_3b
    const-string v4, "aspectx"

    invoke-virtual {v0, v4, v2}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeInt(Ljava/lang/String;I)I

    move-result v4

    iput v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mAspectX:I

    const-string v4, "aspecty"

    invoke-virtual {v0, v4, v2}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeInt(Ljava/lang/String;I)I

    move-result v4

    iput v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mAspectY:I

    const-string v4, "width"

    invoke-virtual {v0, v4, v2}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeInt(Ljava/lang/String;I)I

    move-result v4

    iput v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mWidth:I

    const-string v4, "height"

    invoke-virtual {v0, v4, v2}, Landroidx/preference/XMiuiPreferenceHelper;->getAttributeInt(Ljava/lang/String;I)I

    move-result v4

    iput v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mHeight:I

    iget v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mAspectY:I

    if-eqz v4, :cond_63

    iget v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mAspectX:I

    if-nez v4, :cond_6b

    :cond_63
    iget v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mHeight:I

    if-eqz v4, :cond_13

    iget v4, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mWidth:I

    if-eqz v4, :cond_13

    :cond_6b
    move v2, v3

    goto :goto_13
.end method

.method private static sendToast(Landroid/content/Context;Ljava/lang/String;)V
    .registers 4

    const/4 v1, 0x0

    invoke-static {p0, p1, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method private setPreviewPicture()V
    .registers 10

    const/4 v8, 0x0

    const/high16 v7, 0x42200000  # 40.0f

    iget-object v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mView:Landroid/view/View;

    if-nez v5, :cond_c

    iget-boolean v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mThumb:Z

    if-nez v5, :cond_c

    :cond_b
    :goto_b
    return-void

    :cond_c
    new-instance v5, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;

    invoke-virtual {p0}, Landroidx/preference/XMiuiPictureSelectionPreference;->getContext()Landroid/content/Context;

    move-result-object v6

    invoke-direct {v5, v6}, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;-><init>(Landroid/content/Context;)V

    const/16 v6, 0x1e

    invoke-virtual {v5, v6}, Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;->setRadius(I)Landroidx/preference/XMiuiPictureSelectionPreference$RoundCornerImageView;

    move-result-object v1

    iget-object v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mView:Landroid/view/View;

    const v6, 0x1020018

    invoke-virtual {v5, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/LinearLayout;

    new-instance v3, Landroid/widget/LinearLayout$LayoutParams;

    iget v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mDensity:F

    mul-float/2addr v5, v7

    float-to-int v5, v5

    iget v6, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mDensity:F

    mul-float/2addr v6, v7

    float-to-int v6, v6

    invoke-direct {v3, v5, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/16 v5, 0x11

    iput v5, v3, Landroid/widget/LinearLayout$LayoutParams;->gravity:I

    iget v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mDensity:F

    const/high16 v6, 0x40a00000  # 5.0f

    mul-float/2addr v5, v6

    float-to-int v2, v5

    int-to-float v5, v2

    const/high16 v6, 0x3fc00000  # 1.5f

    mul-float/2addr v5, v6

    float-to-int v5, v5

    invoke-virtual {v3, v2, v2, v5, v2}, Landroid/widget/LinearLayout$LayoutParams;->setMargins(IIII)V

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    sget-object v5, Landroid/widget/ImageView$ScaleType;->CENTER_CROP:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    if-eqz v4, :cond_b

    invoke-virtual {v4, v8}, Landroid/widget/LinearLayout;->setVisibility(I)V

    invoke-virtual {v4}, Landroid/widget/LinearLayout;->getChildCount()I

    move-result v0

    if-lez v0, :cond_5b

    invoke-virtual {v4, v8, v0}, Landroid/widget/LinearLayout;->removeViews(II)V

    :cond_5b
    invoke-virtual {v4, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-virtual {v5}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_b

    iget-object v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mContext:Landroid/content/Context;

    iget-object v6, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-static {v5, v6}, Landroidx/preference/XMiuiPictureSelectionPreference;->getDrawable(Landroid/content/Context;Ljava/lang/String;)Landroid/graphics/drawable/Drawable;

    move-result-object v5

    iput-object v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mDrawableIcon:Landroid/graphics/drawable/Drawable;

    iget-object v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mDrawableIcon:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    invoke-virtual {v1}, Landroid/widget/ImageView;->invalidate()V

    iget-object v5, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mDrawableIcon:Landroid/graphics/drawable/Drawable;

    if-eqz v5, :cond_b

    new-instance v5, Landroidx/preference/XMiuiPictureSelectionPreference$2;

    invoke-direct {v5, p0}, Landroidx/preference/XMiuiPictureSelectionPreference$2;-><init>(Landroidx/preference/XMiuiPictureSelectionPreference;)V

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_b
.end method


# virtual methods
.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 6

    invoke-super {p0, p1}, Landroidx/preference/Preference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    iget-object v0, p1, Landroidx/preference/PreferenceViewHolder;->itemView:Landroid/view/View;

    iput-object v0, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mView:Landroid/view/View;

    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    new-instance v1, Landroidx/preference/XMiuiPictureSelectionPreference$3;

    invoke-direct {v1, p0}, Landroidx/preference/XMiuiPictureSelectionPreference$3;-><init>(Landroidx/preference/XMiuiPictureSelectionPreference;)V

    const-wide/16 v2, 0xc8

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    return-void
.end method

.method protected onClick()V
    .registers 4

    iget-boolean v1, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mOk:Z

    if-eqz v1, :cond_34

    invoke-super {p0}, Landroidx/preference/Preference;->onClick()V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "picture_select_result"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :try_start_1c
    invoke-virtual {p0}, Landroidx/preference/XMiuiPictureSelectionPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {p0}, Landroidx/preference/XMiuiPictureSelectionPreference;->getStartIntent()Landroid/content/Intent;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    invoke-static {}, Landroid/preference/CustomUpdater;->getInstance()Landroid/preference/CustomUpdater;

    move-result-object v1

    new-instance v2, Landroidx/preference/XMiuiPictureSelectionPreference$1;

    invoke-direct {v2, p0, v0}, Landroidx/preference/XMiuiPictureSelectionPreference$1;-><init>(Landroidx/preference/XMiuiPictureSelectionPreference;Ljava/lang/String;)V

    invoke-virtual {v1, v2, v0}, Landroid/preference/CustomUpdater;->addCustomReceiver(Landroid/preference/CustomUpdater$CustomReceiver;Ljava/lang/String;)V
    :try_end_33
    .catch Ljava/lang/Exception; {:try_start_1c .. :try_end_33} :catch_3c

    :goto_33
    return-void

    :cond_34
    iget-object v1, p0, Landroidx/preference/XMiuiPictureSelectionPreference;->mContext:Landroid/content/Context;

    const-string v2, "Whoops - Attribute not correct!"

    invoke-static {v1, v2}, Landroidx/preference/XMiuiPictureSelectionPreference;->sendToast(Landroid/content/Context;Ljava/lang/String;)V

    goto :goto_33

    :catch_3c
    move-exception v1

    goto :goto_33
.end method
