# classes11.dex

.class Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroidx/preference/FixedSize/PointSeekBarLayout$PointChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->getCustomeTitle()Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

.field final synthetic val$finalKey:Ljava/lang/String;

.field final synthetic val$main:Landroidx/preference/FixedSize/PointSeekBarLayout;


# direct methods
.method constructor <init>(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;Ljava/lang/String;Landroidx/preference/FixedSize/PointSeekBarLayout;)V
    .registers 4

    iput-object p1, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;->this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

    iput-object p2, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;->val$finalKey:Ljava/lang/String;

    iput-object p3, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;->val$main:Landroidx/preference/FixedSize/PointSeekBarLayout;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public OnPointChange(I)V
    .registers 5

    iget-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;->val$finalKey:Ljava/lang/String;

    invoke-static {v0, p1}, Landroid/preference/SettingsMezoHelper;->putIntinSettings(Ljava/lang/String;I)V

    iget-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;->val$main:Landroidx/preference/FixedSize/PointSeekBarLayout;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Font : "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;->this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

    invoke-static {v2, p1}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->access$200(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroidx/preference/FixedSize/PointSeekBarLayout;->setTitle(Ljava/lang/String;)V

    iget-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;->this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

    invoke-static {v0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->access$300(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;)V

    iget-object v0, p0, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat$2;->this$0:Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;

    invoke-static {v0}, Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;->access$400(Lmiuix/preference/FontStylePreferenceDialogFragmentCompat;)Landroidx/preference/MiuiFontStylePreference;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/preference/MiuiFontStylePreference;->sendIntent()V

    return-void
.end method
