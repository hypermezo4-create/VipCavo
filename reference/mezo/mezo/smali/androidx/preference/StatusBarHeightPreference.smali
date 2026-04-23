# classes10.dex

.class public Landroidx/preference/StatusBarHeightPreference;
.super Landroidx/preference/Preference;
.source "StatusBarHeightPreference.java"

# interfaces
.implements Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;
.implements Landroid/content/DialogInterface$OnClickListener;


# instance fields
.field private dialogShowing:Z

.field private seekBarDialog:Lmiuix/settings/example/SeekBarDialog;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .registers 4

    invoke-direct {p0, p1, p2}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/preference/StatusBarHeightPreference;->dialogShowing:Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .registers 5

    invoke-direct {p0, p1, p2, p3}, Landroidx/preference/Preference;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    const/4 v0, 0x0

    iput-boolean v0, p0, Landroidx/preference/StatusBarHeightPreference;->dialogShowing:Z

    return-void
.end method


# virtual methods
.method protected onClick()V
    .registers 6

    invoke-super {p0}, Landroidx/preference/Preference;->onClick()V

    iget-boolean v0, p0, Landroidx/preference/StatusBarHeightPreference;->dialogShowing:Z

    if-nez v0, :cond_4f

    const/4 v0, 0x1

    iput-boolean v0, p0, Landroidx/preference/StatusBarHeightPreference;->dialogShowing:Z

    new-instance v1, Lmiuix/settings/example/SeekBarDialog;

    invoke-virtual {p0}, Landroidx/preference/StatusBarHeightPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Lmiuix/settings/example/SeekBarDialog;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Landroidx/preference/StatusBarHeightPreference;->seekBarDialog:Lmiuix/settings/example/SeekBarDialog;

    const/16 v2, 0x32

    invoke-virtual {v1, v2}, Lmiuix/settings/example/SeekBarDialog;->setMin(I)Lmiuix/settings/example/SeekBarDialog;

    move-result-object v1

    const/16 v2, 0xfa

    invoke-virtual {v1, v2}, Lmiuix/settings/example/SeekBarDialog;->setMax(I)Lmiuix/settings/example/SeekBarDialog;

    move-result-object v1

    invoke-virtual {p0}, Landroidx/preference/StatusBarHeightPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v2

    const/16 v3, 0x63

    const-string v4, "custom_status_bar_height"

    invoke-static {v2, v4, v3}, Landroid/provider/Settings$Global;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    invoke-virtual {v1, v2}, Lmiuix/settings/example/SeekBarDialog;->setCurent(I)Lmiuix/settings/example/SeekBarDialog;

    move-result-object v1

    invoke-virtual {v1, p0}, Lmiuix/settings/example/SeekBarDialog;->setOnProgressChangeListener(Lmiuix/settings/example/SeekBarDialog$OnProgressChangeListener;)Lmiuix/settings/example/SeekBarDialog;

    move-result-object v1

    invoke-virtual {v1, p0}, Lmiuix/settings/example/SeekBarDialog;->setPositiveClickListener(Landroid/content/DialogInterface$OnClickListener;)Lmiuix/settings/example/SeekBarDialog;

    move-result-object v1

    const-string v2, "Status bar size"

    invoke-virtual {v1, v2}, Lmiuix/settings/example/SeekBarDialog;->setTitle(Ljava/lang/String;)Lmiuix/settings/example/SeekBarDialog;

    move-result-object v1

    invoke-virtual {v1}, Lmiuix/settings/example/SeekBarDialog;->init()Lmiuix/settings/example/SeekBarDialog;

    move-result-object v1

    invoke-virtual {v1}, Lmiuix/settings/example/SeekBarDialog;->show()Lmiuix/appcompat/app/AlertDialog;

    const-string v1, "custom_statusbar_dialog_open"

    invoke-static {v1, v0}, Landroid/preference/SettingsMezoHelper;->putBoolinSettings(Ljava/lang/String;Z)V

    :cond_4f
    return-void
.end method

.method public onClick(Landroid/content/DialogInterface;I)V
    .registers 5

    const-string v0, "custom_statusbar_dialog_open"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/preference/SettingsMezoHelper;->putBoolinSettings(Ljava/lang/String;Z)V

    iput-boolean v1, p0, Landroidx/preference/StatusBarHeightPreference;->dialogShowing:Z

    return-void
.end method

.method public onProgressChange(I)V
    .registers 4

    invoke-virtual {p0}, Landroidx/preference/StatusBarHeightPreference;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v0

    const-string v1, "custom_status_bar_height"

    invoke-static {v0, v1, p1}, Landroid/provider/Settings$Global;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    return-void
.end method

.method public onStopTouch(I)V
    .registers 2

    return-void
.end method

.method public onVisibilityAggregated(Z)V
    .registers 5

    sget-object v0, Landroidx/preference/MiuiPreferenceHelper;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onVisibilityAggregated: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    if-nez p1, :cond_2b

    iget-boolean v0, p0, Landroidx/preference/StatusBarHeightPreference;->dialogShowing:Z

    if-eqz v0, :cond_2b

    iget-object v0, p0, Landroidx/preference/StatusBarHeightPreference;->seekBarDialog:Lmiuix/settings/example/SeekBarDialog;

    invoke-virtual {v0}, Lmiuix/settings/example/SeekBarDialog;->dismiss()Lmiuix/appcompat/app/AlertDialog;

    const-string v0, "custom_statusbar_dialog_open"

    const/4 v1, 0x0

    invoke-static {v0, v1}, Landroid/preference/SettingsMezoHelper;->putBoolinSettings(Ljava/lang/String;Z)V

    iput-boolean v1, p0, Landroidx/preference/StatusBarHeightPreference;->dialogShowing:Z

    :cond_2b
    return-void
.end method
