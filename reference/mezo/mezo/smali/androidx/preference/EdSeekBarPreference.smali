# classes10.dex

.class public Landroidx/preference/EdSeekBarPreference;
.super Landroidx/preference/Preference;
.source "EdSeekBarPreference.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# static fields
.field private static final UNSET_VALUE:I = -0x80000000


# instance fields
.field private final BUILD_VAR:Ljava/lang/String;

.field private final intentAction:Ljava/lang/String;

.field private isHideNavigation:Z

.field private isHideResetButton:Z

.field private final isProperty:Z

.field private mContext:Landroid/content/Context;

.field public mContinuousUpdates:Z

.field public mDefaultValue:I

.field public mDefaultValueExists:Z

.field public mDefaultValueText:Ljava/lang/String;

.field public mDefaultValueTextExists:Z

.field public mInterval:I

.field private final mKey:Ljava/lang/String;

.field public mMaxValue:I

.field public mMinValue:I

.field public mMinusImageView:Landroid/widget/ImageView;

.field public mPlusImageView:Landroid/widget/ImageView;

.field public mResetTextView:Landroid/widget/TextView;

.field public mSeekBar:Landroid/widget/SeekBar;

.field private mSettingProgress:Z

.field public mShowSign:Z

.field public mTitle:Landroid/widget/TextView;

.field public mTrackingTouch:Z

.field public mTrackingValue:I

.field public mUnits:Ljava/lang/String;

.field public mValue:I

.field public mValueTextView:Landroid/widget/TextView;

.field private final preferenceHelper:Landroidx/preference/EdPreferenceHelper;

.field private final storeType:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .registers 3

    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Landroidx/preference/EdSeekBarPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 5

    sget v0, Landroidx/preference/R$attr;->seekBarPreferenceStyle:I

    const/4 v1, 0x0

    invoke-static {p1, v0, v1}, Landroidx/core/content/res/TypedArrayUtils;->getAttr(Landroid/content/Context;II)I

    move-result v0

    invoke-direct {p0, p1, p2, v0}, Landroidx/preference/EdSeekBarPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 5

    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Landroidx/preference/EdSeekBarPreference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .registers 12

    invoke-direct {p0, p1, p2, p3, p4}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    const-string v0, "v4.2"

    iput-object v0, p0, Landroidx/preference/EdSeekBarPreference;->BUILD_VAR:Ljava/lang/String;

    const/4 v1, 0x1

    iput v1, p0, Landroidx/preference/EdSeekBarPreference;->mInterval:I

    const/4 v2, 0x0

    iput-boolean v2, p0, Landroidx/preference/EdSeekBarPreference;->mShowSign:Z

    const-string v3, ""

    iput-object v3, p0, Landroidx/preference/EdSeekBarPreference;->mUnits:Ljava/lang/String;

    iput-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mContinuousUpdates:Z

    iput v2, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    const/16 v3, 0x64

    iput v3, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    iput-boolean v2, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueExists:Z

    iput-boolean v2, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueTextExists:Z

    iput-boolean v2, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingTouch:Z

    iput-object p1, p0, Landroidx/preference/EdSeekBarPreference;->mContext:Landroid/content/Context;

    new-instance v3, Landroidx/preference/EdPreferenceHelper;

    invoke-virtual {p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v4

    invoke-direct {v3, p1, p2, v4, v0}, Landroidx/preference/EdPreferenceHelper;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;Landroid/content/ContentResolver;Ljava/lang/String;)V

    iput-object v3, p0, Landroidx/preference/EdSeekBarPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    invoke-virtual {p0}, Landroidx/preference/EdSeekBarPreference;->getKey()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mKey:Ljava/lang/String;

    const-string v0, "showSign"

    iget-boolean v3, p0, Landroidx/preference/EdSeekBarPreference;->mShowSign:Z

    const/4 v4, 0x0

    invoke-interface {p2, v4, v0, v3}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v0

    iput-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->mShowSign:Z

    const-string v0, "units"

    invoke-interface {p2, v4, v0}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_5a

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, " "

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    iput-object v3, p0, Landroidx/preference/EdSeekBarPreference;->mUnits:Ljava/lang/String;

    :cond_5a
    const-string v3, "continuousUpdates"

    iget-boolean v5, p0, Landroidx/preference/EdSeekBarPreference;->mContinuousUpdates:Z

    invoke-interface {p2, v4, v3, v5}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v3

    iput-boolean v3, p0, Landroidx/preference/EdSeekBarPreference;->mContinuousUpdates:Z

    const-string v3, "defaultValueText"

    invoke-interface {p2, v4, v3}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    if-eqz v3, :cond_74

    invoke-virtual {v3}, Ljava/lang/String;->isEmpty()Z

    move-result v5

    if-nez v5, :cond_74

    move v5, v1

    goto :goto_75

    :cond_74
    move v5, v2

    :goto_75
    iput-boolean v5, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueTextExists:Z

    iget-boolean v5, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueTextExists:Z

    if-eqz v5, :cond_7d

    iput-object v3, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueText:Ljava/lang/String;

    :cond_7d
    const-string v5, "step"

    iget v6, p0, Landroidx/preference/EdSeekBarPreference;->mInterval:I

    invoke-interface {p2, v4, v5, v6}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v5

    iput v5, p0, Landroidx/preference/EdSeekBarPreference;->mInterval:I

    const-string v5, "min"

    iget v6, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    invoke-interface {p2, v4, v5, v6}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v5

    iput v5, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    const-string v5, "max"

    iget v6, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    invoke-interface {p2, v4, v5, v6}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v5

    iput v5, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    iget v5, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    iget v6, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    if-ge v5, v6, :cond_a5

    iget v5, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    iput v5, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    :cond_a5
    const-string v5, "storeType"

    invoke-interface {p2, v4, v5, v2}, Landroid/util/AttributeSet;->getAttributeIntValue(Ljava/lang/String;Ljava/lang/String;I)I

    move-result v5

    iput v5, p0, Landroidx/preference/EdSeekBarPreference;->storeType:I

    const-string v5, "isProp"

    invoke-interface {p2, v4, v5, v2}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v5

    iput-boolean v5, p0, Landroidx/preference/EdSeekBarPreference;->isProperty:Z

    const-string v5, "hideNav"

    invoke-interface {p2, v4, v5, v2}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v5

    iput-boolean v5, p0, Landroidx/preference/EdSeekBarPreference;->isHideNavigation:Z

    const-string v5, "hideReset"

    invoke-interface {p2, v4, v5, v2}, Landroid/util/AttributeSet;->getAttributeBooleanValue(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v5

    iput-boolean v5, p0, Landroidx/preference/EdSeekBarPreference;->isHideResetButton:Z

    const-string v5, "intent"

    invoke-interface {p2, v4, v5}, Landroid/util/AttributeSet;->getAttributeValue(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iput-object v4, p0, Landroidx/preference/EdSeekBarPreference;->intentAction:Ljava/lang/String;

    iget v4, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    invoke-static {v4}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    if-eqz v4, :cond_d6

    goto :goto_d7

    :cond_d6
    move v1, v2

    :goto_d7
    iput-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueExists:Z

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->isProperty:Z

    const/high16 v2, -0x80000000

    if-eqz v1, :cond_f0

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v4, p0, Landroidx/preference/EdSeekBarPreference;->mKey:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v4, v2}, Landroidx/preference/EdPreferenceHelper;->getPropString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    goto :goto_fa

    :cond_f0
    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v4, p0, Landroidx/preference/EdSeekBarPreference;->mKey:Ljava/lang/String;

    iget v5, p0, Landroidx/preference/EdSeekBarPreference;->storeType:I

    invoke-virtual {v1, v4, v2, v5}, Landroidx/preference/EdPreferenceHelper;->getInt(Ljava/lang/String;II)I

    move-result v1

    :goto_fa
    iput v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    const-string v2, "ed_seekbar_layout"

    invoke-virtual {v1, v2}, Landroidx/preference/EdPreferenceHelper;->getLayout(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0, v1}, Landroidx/preference/EdSeekBarPreference;->setLayoutResource(I)V

    return-void
.end method

.method private getLimitedValue(I)I
    .registers 3

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    if-ge p1, v0, :cond_7

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    goto :goto_f

    :cond_7
    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    if-le p1, v0, :cond_e

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    goto :goto_f

    :cond_e
    move v0, p1

    :goto_f
    return v0
.end method

.method private getSeekValue(I)I
    .registers 4

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    sub-int/2addr v0, p1

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mInterval:I

    invoke-static {v0, v1}, Ljava/lang/Math;->floorDiv(II)I

    move-result v0

    neg-int v0, v0

    if-ltz v0, :cond_d

    return v0

    :cond_d
    const/4 v1, -0x1

    return v1
.end method

.method private getTextValue(I)Ljava/lang/String;
    .registers 4

    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueTextExists:Z

    if-eqz v0, :cond_f

    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueExists:Z

    if-eqz v0, :cond_f

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    if-ne p1, v0, :cond_f

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueText:Ljava/lang/String;

    return-object v0

    :cond_f
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mShowSign:Z

    if-eqz v1, :cond_1d

    if-lez p1, :cond_1d

    const-string v1, "+"

    goto :goto_1f

    :cond_1d
    const-string v1, ""

    :goto_1f
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->mUnits:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private onClickLogics()V
    .registers 3

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mValueTextView:Landroid/widget/TextView;

    new-instance v1, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0}, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda0;-><init>(Landroidx/preference/EdSeekBarPreference;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->isHideNavigation:Z

    if-nez v0, :cond_36

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    new-instance v1, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda1;-><init>(Landroidx/preference/EdSeekBarPreference;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    new-instance v1, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda2;-><init>(Landroidx/preference/EdSeekBarPreference;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    new-instance v1, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda3;-><init>(Landroidx/preference/EdSeekBarPreference;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    new-instance v1, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda4;-><init>(Landroidx/preference/EdSeekBarPreference;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    :cond_36
    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->isHideResetButton:Z

    if-nez v0, :cond_45

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mResetTextView:Landroid/widget/TextView;

    new-instance v1, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda5;

    invoke-direct {v1, p0}, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda5;-><init>(Landroidx/preference/EdSeekBarPreference;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    goto :goto_4f

    :cond_45
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mValueTextView:Landroid/widget/TextView;

    new-instance v1, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda6;

    invoke-direct {v1, p0}, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda6;-><init>(Landroidx/preference/EdSeekBarPreference;)V

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setOnLongClickListener(Landroid/view/View$OnLongClickListener;)V

    :goto_4f
    return-void
.end method

.method private setKeyValues(I)V
    .registers 5

    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->isProperty:Z

    if-eqz v0, :cond_10

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->mKey:Ljava/lang/String;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Landroidx/preference/EdPreferenceHelper;->putPropString(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_19

    :cond_10
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->mKey:Ljava/lang/String;

    iget v2, p0, Landroidx/preference/EdSeekBarPreference;->storeType:I

    invoke-virtual {v0, v1, p1, v2}, Landroidx/preference/EdPreferenceHelper;->putInt(Ljava/lang/String;II)V

    :goto_19
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->intentAction:Ljava/lang/String;

    if-eqz v0, :cond_24

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->preferenceHelper:Landroidx/preference/EdPreferenceHelper;

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->intentAction:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroidx/preference/EdPreferenceHelper;->sendIntent(Ljava/lang/String;)V

    :cond_24
    return-void
.end method

.method private setValue(I)V
    .registers 4

    invoke-direct {p0, p1}, Landroidx/preference/EdSeekBarPreference;->getLimitedValue(I)I

    move-result v0

    iput v0, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    if-eqz v0, :cond_15

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    invoke-direct {p0, v1}, Landroidx/preference/EdSeekBarPreference;->getSeekValue(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgress(I)V

    :cond_15
    return-void
.end method

.method private setValue(IZ)V
    .registers 5

    invoke-direct {p0, p1}, Landroidx/preference/EdSeekBarPreference;->getLimitedValue(I)I

    move-result p1

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    if-eq v0, p1, :cond_16

    if-eqz p2, :cond_14

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    invoke-direct {p0, p1}, Landroidx/preference/EdSeekBarPreference;->getSeekValue(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgress(I)V

    goto :goto_16

    :cond_14
    iput p1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    :cond_16
    :goto_16
    return-void
.end method

.method private updateValueViews()V
    .registers 6

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mResetTextView:Landroid/widget/TextView;

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueExists:Z

    const/4 v2, 0x0

    if-eqz v1, :cond_f

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    iget v3, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    if-eq v1, v3, :cond_f

    move v1, v2

    goto :goto_11

    :cond_f
    const/16 v1, 0x8

    :goto_11
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingTouch:Z

    if-eqz v0, :cond_3a

    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->mContinuousUpdates:Z

    if-eqz v0, :cond_1d

    goto :goto_3a

    :cond_1d
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mValueTextView:Landroid/widget/TextView;

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueTextExists:Z

    if-eqz v1, :cond_30

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueExists:Z

    if-eqz v1, :cond_30

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingValue:I

    iget v3, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    if-ne v1, v3, :cond_30

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueText:Ljava/lang/String;

    goto :goto_36

    :cond_30
    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingValue:I

    invoke-direct {p0, v1}, Landroidx/preference/EdSeekBarPreference;->getTextValue(I)Ljava/lang/String;

    move-result-object v1

    :goto_36
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_56

    :cond_3a
    :goto_3a
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mValueTextView:Landroid/widget/TextView;

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueTextExists:Z

    if-eqz v1, :cond_4d

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueExists:Z

    if-eqz v1, :cond_4d

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    iget v3, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    if-ne v1, v3, :cond_4d

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValueText:Ljava/lang/String;

    goto :goto_53

    :cond_4d
    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    invoke-direct {p0, v1}, Landroidx/preference/EdSeekBarPreference;->getTextValue(I)Ljava/lang/String;

    move-result-object v1

    :goto_53
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_56
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    iget v3, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    const/4 v4, 0x1

    if-le v1, v3, :cond_65

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingTouch:Z

    if-nez v1, :cond_65

    move v1, v4

    goto :goto_66

    :cond_65
    move v1, v2

    :goto_66
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setClickable(Z)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    iget v3, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    if-ge v1, v3, :cond_76

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingTouch:Z

    if-nez v1, :cond_76

    move v2, v4

    :cond_76
    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setClickable(Z)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->clearColorFilter()V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->clearColorFilter()V

    return-void
.end method


# virtual methods
.method synthetic lambda$onClickLogics$0$androidx-preference-EdSeekBarPreference(Landroid/view/View;)V
    .registers 5

    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->isHideResetButton:Z

    if-eqz v0, :cond_7

    const-string v0, "Default value: %s\nTap Reset button to set"

    goto :goto_9

    :cond_7
    const-string v0, "Default value: %s\nLong Press on value to set"

    :goto_9
    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    invoke-direct {p0, v1}, Landroidx/preference/EdSeekBarPreference;->getTextValue(I)Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Landroidx/preference/EdSeekBarPreference;->getContext()Landroid/content/Context;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v1, v0, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    return-void
.end method

.method synthetic lambda$onClickLogics$1$androidx-preference-EdSeekBarPreference(Landroid/view/View;)V
    .registers 4

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mInterval:I

    sub-int/2addr v0, v1

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Landroidx/preference/EdSeekBarPreference;->setValue(IZ)V

    return-void
.end method

.method synthetic lambda$onClickLogics$2$androidx-preference-EdSeekBarPreference(Landroid/view/View;)Z
    .registers 5

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    sub-int/2addr v0, v1

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mInterval:I

    const/4 v2, 0x2

    mul-int/2addr v1, v2

    if-le v0, v1, :cond_1f

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    add-int/2addr v0, v1

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    mul-int/2addr v1, v2

    if-ge v0, v1, :cond_1f

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    add-int/2addr v0, v1

    invoke-static {v0, v2}, Ljava/lang/Math;->floorDiv(II)I

    move-result v0

    goto :goto_21

    :cond_1f
    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    :goto_21
    nop

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Landroidx/preference/EdSeekBarPreference;->setValue(IZ)V

    return v1
.end method

.method synthetic lambda$onClickLogics$3$androidx-preference-EdSeekBarPreference(Landroid/view/View;)V
    .registers 4

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mInterval:I

    add-int/2addr v0, v1

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Landroidx/preference/EdSeekBarPreference;->setValue(IZ)V

    return-void
.end method

.method synthetic lambda$onClickLogics$4$androidx-preference-EdSeekBarPreference(Landroid/view/View;)Z
    .registers 5

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    sub-int/2addr v0, v1

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mInterval:I

    const/4 v2, 0x2

    mul-int/2addr v1, v2

    if-le v0, v1, :cond_23

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    add-int/2addr v0, v1

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    mul-int/2addr v1, v2

    if-le v0, v1, :cond_23

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    add-int/2addr v0, v1

    mul-int/lit8 v0, v0, -0x1

    invoke-static {v0, v2}, Ljava/lang/Math;->floorDiv(II)I

    move-result v0

    mul-int/lit8 v0, v0, -0x1

    goto :goto_25

    :cond_23
    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    :goto_25
    nop

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Landroidx/preference/EdSeekBarPreference;->setValue(IZ)V

    return v1
.end method

.method synthetic lambda$onClickLogics$5$androidx-preference-EdSeekBarPreference(Landroid/view/View;)V
    .registers 4

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Landroidx/preference/EdSeekBarPreference;->setValue(IZ)V

    return-void
.end method

.method synthetic lambda$onClickLogics$6$androidx-preference-EdSeekBarPreference(Landroid/view/View;)Z
    .registers 4

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    const/4 v1, 0x1

    invoke-direct {p0, v0, v1}, Landroidx/preference/EdSeekBarPreference;->setValue(IZ)V

    return v1
.end method

.method public onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V
    .registers 6

    invoke-super {p0, p1}, Landroidx/preference/Preference;->onBindViewHolder(Landroidx/preference/PreferenceViewHolder;)V

    const v0, 0x1020016

    invoke-virtual {p1, v0}, Landroidx/preference/PreferenceViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mTitle:Landroid/widget/TextView;

    const v0, 0x1020010

    invoke-virtual {p1, v0}, Landroidx/preference/PreferenceViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mValueTextView:Landroid/widget/TextView;

    const v0, 0x1020032

    invoke-virtual {p1, v0}, Landroidx/preference/PreferenceViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    const v0, 0x102000d

    invoke-virtual {p1, v0}, Landroidx/preference/PreferenceViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/SeekBar;

    iput-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    const v0, 0x1020033

    invoke-virtual {p1, v0}, Landroidx/preference/PreferenceViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    const v0, 0x1020014

    invoke-virtual {p1, v0}, Landroidx/preference/PreferenceViewHolder;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mResetTextView:Landroid/widget/TextView;

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mTitle:Landroid/widget/TextView;

    if-eqz v0, :cond_c6

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    if-eqz v0, :cond_c6

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mValueTextView:Landroid/widget/TextView;

    if-eqz v0, :cond_c6

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    if-eqz v0, :cond_c6

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    if-nez v0, :cond_5e

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mResetTextView:Landroid/widget/TextView;

    if-nez v0, :cond_5e

    goto :goto_c6

    :cond_5e
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    const/4 v1, 0x1

    iput-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mSettingProgress:Z

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mMaxValue:I

    invoke-direct {p0, v1}, Landroidx/preference/EdSeekBarPreference;->getSeekValue(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setMax(I)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    invoke-direct {p0, v1}, Landroidx/preference/EdSeekBarPreference;->getSeekValue(I)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setProgress(I)V

    const/4 v1, 0x0

    iput-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mSettingProgress:Z

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    invoke-virtual {v0, p0}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    invoke-virtual {p0}, Landroidx/preference/EdSeekBarPreference;->isEnabled()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setEnabled(Z)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mTitle:Landroid/widget/TextView;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setSelected(Z)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mValueTextView:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->isHideNavigation:Z

    const/16 v2, 0x8

    if-eqz v0, :cond_ab

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    goto :goto_b5

    :cond_ab
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    :goto_b5
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mResetTextView:Landroid/widget/TextView;

    iget-boolean v3, p0, Landroidx/preference/EdSeekBarPreference;->isHideResetButton:Z

    if-eqz v3, :cond_bc

    move v1, v2

    :cond_bc
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    invoke-direct {p0}, Landroidx/preference/EdSeekBarPreference;->updateValueViews()V

    invoke-direct {p0}, Landroidx/preference/EdSeekBarPreference;->onClickLogics()V

    return-void

    :cond_c6
    :goto_c6
    return-void
.end method

.method public onDependencyChanged(Landroidx/preference/Preference;Z)V
    .registers 5

    invoke-super {p0, p1, p2}, Landroidx/preference/Preference;->onDependencyChanged(Landroidx/preference/Preference;Z)V

    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Landroidx/preference/EdSeekBarPreference;->setShouldDisableView(Z)V

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    if-eqz v0, :cond_12

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    xor-int/lit8 v1, p2, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/SeekBar;->setEnabled(Z)V

    :cond_12
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    if-eqz v0, :cond_1d

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mPlusImageView:Landroid/widget/ImageView;

    xor-int/lit8 v1, p2, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setEnabled(Z)V

    :cond_1d
    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    if-eqz v0, :cond_28

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinusImageView:Landroid/widget/ImageView;

    xor-int/lit8 v1, p2, 0x1

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setEnabled(Z)V

    :cond_28
    return-void
.end method

.method public onGetDefaultValue(Landroid/content/res/TypedArray;I)Ljava/lang/Object;
    .registers 5

    const/4 v0, 0x0

    invoke-virtual {p1, p2, v0}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v0

    iput v0, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    return-object v1
.end method

.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .registers 7

    iget-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->mSettingProgress:Z

    if-eqz v0, :cond_5

    return-void

    :cond_5
    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mMinValue:I

    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mInterval:I

    mul-int/2addr v1, p2

    add-int/2addr v0, v1

    invoke-direct {p0, v0}, Landroidx/preference/EdSeekBarPreference;->getLimitedValue(I)I

    move-result v0

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingTouch:Z

    if-eqz v1, :cond_2b

    iget-boolean v1, p0, Landroidx/preference/EdSeekBarPreference;->mContinuousUpdates:Z

    if-eqz v1, :cond_25

    iput v0, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingValue:I

    invoke-virtual {p0, v0}, Landroidx/preference/EdSeekBarPreference;->persistInt(I)Z

    invoke-direct {p0, v0}, Landroidx/preference/EdSeekBarPreference;->setKeyValues(I)V

    invoke-direct {p0}, Landroidx/preference/EdSeekBarPreference;->updateValueViews()V

    iput v0, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    goto :goto_50

    :cond_25
    iput v0, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingValue:I

    invoke-direct {p0}, Landroidx/preference/EdSeekBarPreference;->updateValueViews()V

    goto :goto_50

    :cond_2b
    iget v1, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    if-eq v1, v0, :cond_50

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {p0, v1}, Landroidx/preference/EdSeekBarPreference;->callChangeListener(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_45

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    iget v2, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    invoke-direct {p0, v2}, Landroidx/preference/EdSeekBarPreference;->getSeekValue(I)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/widget/SeekBar;->setProgress(I)V

    return-void

    :cond_45
    invoke-virtual {p0, v0}, Landroidx/preference/EdSeekBarPreference;->persistInt(I)Z

    iput v0, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    invoke-direct {p0}, Landroidx/preference/EdSeekBarPreference;->updateValueViews()V

    invoke-direct {p0, v0}, Landroidx/preference/EdSeekBarPreference;->setKeyValues(I)V

    :cond_50
    :goto_50
    return-void
.end method

.method public onSetInitialValue(Ljava/lang/Object;)V
    .registers 4

    instance-of v0, p1, Ljava/lang/Integer;

    if-eqz v0, :cond_d

    move-object v0, p1

    check-cast v0, Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    :cond_d
    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    const/high16 v1, -0x80000000

    if-ne v0, v1, :cond_18

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mDefaultValue:I

    invoke-direct {p0, v0}, Landroidx/preference/EdSeekBarPreference;->setValue(I)V

    :cond_18
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .registers 3

    iget v0, p0, Landroidx/preference/EdSeekBarPreference;->mValue:I

    iput v0, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingValue:I

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingTouch:Z

    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .registers 5

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingTouch:Z

    iget-object v1, p0, Landroidx/preference/EdSeekBarPreference;->mSeekBar:Landroid/widget/SeekBar;

    iget v2, p0, Landroidx/preference/EdSeekBarPreference;->mTrackingValue:I

    invoke-direct {p0, v2}, Landroidx/preference/EdSeekBarPreference;->getSeekValue(I)I

    move-result v2

    invoke-virtual {p0, v1, v2, v0}, Landroidx/preference/EdSeekBarPreference;->onProgressChanged(Landroid/widget/SeekBar;IZ)V

    invoke-virtual {p0}, Landroidx/preference/EdSeekBarPreference;->notifyChanged()V

    return-void
.end method
