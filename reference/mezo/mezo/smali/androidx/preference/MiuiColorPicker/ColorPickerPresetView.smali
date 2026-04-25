# classes10.dex

.class public Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;
.super Landroid/view/View;
.source "ColorPickerPresetView.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;
    }
.end annotation


# instance fields
.field private mColor:I

.field private mListener:Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;I)V
    .registers 3

    invoke-direct {p0, p1}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;-><init>(Landroid/content/Context;)V

    iput p2, p0, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->mColor:I

    invoke-virtual {p0, p0}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    invoke-virtual {p0}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->init()V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 3

    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method


# virtual methods
.method public init()V
    .registers 4

    const-string v0, "colorwer"

    const-string v1, "init: "

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    new-instance v0, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v0}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const/high16 v1, 0x42240000  # 41.0f

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    iget v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->mColor:I

    sget-object v2, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-virtual {v0, v1, v2}, Landroid/graphics/drawable/GradientDrawable;->setColorFilter(ILandroid/graphics/PorterDuff$Mode;)V

    invoke-virtual {p0, v0}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->mListener:Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;

    if-eqz v0, :cond_9

    iget v1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->mColor:I

    invoke-interface {v0, v1}, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;->onPresetClick(I)V

    :cond_9
    return-void
.end method

.method public setOnPresetClickListener(Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/MiuiColorPicker/ColorPickerPresetView;->mListener:Landroidx/preference/MiuiColorPicker/ColorPickerPresetView$OnPresetClickListener;

    return-void
.end method
