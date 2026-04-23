# classes10.dex

.class Landroidx/preference/MiuiShapeSelectPreference$1$1;
.super Ljava/lang/Object;
.source "MiuiShapeSelectPreference.java"

# interfaces
.implements Landroidx/preference/ShapeSelect/ShapeSelect$OnShapeChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/MiuiShapeSelectPreference$1;->onPreferenceClick(Landroidx/preference/Preference;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Landroidx/preference/MiuiShapeSelectPreference$1;


# direct methods
.method constructor <init>(Landroidx/preference/MiuiShapeSelectPreference$1;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/MiuiShapeSelectPreference$1$1;->this$1:Landroidx/preference/MiuiShapeSelectPreference$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public OnShapeChange(I)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference$1$1;->this$1:Landroidx/preference/MiuiShapeSelectPreference$1;

    iget-object v0, v0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    invoke-static {v0}, Landroidx/preference/MiuiShapeSelectPreference;->access$100(Landroidx/preference/MiuiShapeSelectPreference;)Landroidx/preference/MiuiPreferenceHelper;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroidx/preference/MiuiPreferenceHelper;->setInt(I)V

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference$1$1;->this$1:Landroidx/preference/MiuiShapeSelectPreference$1;

    iget-object v0, v0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    invoke-static {v0}, Landroidx/preference/MiuiShapeSelectPreference;->access$100(Landroidx/preference/MiuiShapeSelectPreference;)Landroidx/preference/MiuiPreferenceHelper;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/preference/MiuiPreferenceHelper;->sendIntent()V

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference$1$1;->this$1:Landroidx/preference/MiuiShapeSelectPreference$1;

    iget-object v0, v0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    invoke-static {v0}, Landroidx/preference/MiuiShapeSelectPreference;->access$200(Landroidx/preference/MiuiShapeSelectPreference;)V

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference$1$1;->this$1:Landroidx/preference/MiuiShapeSelectPreference$1;

    iget-object v0, v0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroidx/preference/MiuiShapeSelectPreference;->callChangeListener(Ljava/lang/Object;)Z

    return-void
.end method
