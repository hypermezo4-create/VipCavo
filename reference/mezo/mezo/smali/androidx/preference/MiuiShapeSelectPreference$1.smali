# classes10.dex

.class Landroidx/preference/MiuiShapeSelectPreference$1;
.super Ljava/lang/Object;
.source "MiuiShapeSelectPreference.java"

# interfaces
.implements Landroidx/preference/Preference$OnPreferenceClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/MiuiShapeSelectPreference;->init()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/MiuiShapeSelectPreference;


# direct methods
.method constructor <init>(Landroidx/preference/MiuiShapeSelectPreference;)V
    .registers 2

    iput-object p1, p0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onPreferenceClick(Landroidx/preference/Preference;)Z
    .registers 7

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    new-instance v1, Landroidx/preference/ShapeSelect/ShapeSelect;

    iget-object v2, p0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    invoke-virtual {v2}, Landroidx/preference/MiuiShapeSelectPreference;->getContext()Landroid/content/Context;

    move-result-object v2

    const/4 v3, 0x0

    iget-object v4, p0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    invoke-static {v4}, Landroidx/preference/MiuiShapeSelectPreference;->access$300(Landroidx/preference/MiuiShapeSelectPreference;)Z

    move-result v4

    invoke-direct {v1, v2, v3, v4}, Landroidx/preference/ShapeSelect/ShapeSelect;-><init>(Landroid/content/Context;IZ)V

    new-instance v2, Landroidx/preference/MiuiShapeSelectPreference$1$1;

    invoke-direct {v2, p0}, Landroidx/preference/MiuiShapeSelectPreference$1$1;-><init>(Landroidx/preference/MiuiShapeSelectPreference$1;)V

    invoke-virtual {v1, v2}, Landroidx/preference/ShapeSelect/ShapeSelect;->setOnShapeChangeListener(Landroidx/preference/ShapeSelect/ShapeSelect$OnShapeChangeListener;)Landroidx/preference/ShapeSelect/ShapeSelect;

    move-result-object v1

    iget-object v2, p0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    invoke-static {v2}, Landroidx/preference/MiuiShapeSelectPreference;->access$100(Landroidx/preference/MiuiShapeSelectPreference;)Landroidx/preference/MiuiPreferenceHelper;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/preference/MiuiPreferenceHelper;->getInt()I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/preference/ShapeSelect/ShapeSelect;->setCurrentShape(I)Landroidx/preference/ShapeSelect/ShapeSelect;

    move-result-object v1

    invoke-static {v0, v1}, Landroidx/preference/MiuiShapeSelectPreference;->access$002(Landroidx/preference/MiuiShapeSelectPreference;Landroidx/preference/ShapeSelect/ShapeSelect;)Landroidx/preference/ShapeSelect/ShapeSelect;

    iget-object v0, p0, Landroidx/preference/MiuiShapeSelectPreference$1;->this$0:Landroidx/preference/MiuiShapeSelectPreference;

    invoke-static {v0}, Landroidx/preference/MiuiShapeSelectPreference;->access$000(Landroidx/preference/MiuiShapeSelectPreference;)Landroidx/preference/ShapeSelect/ShapeSelect;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/preference/ShapeSelect/ShapeSelect;->show()Lmiuix/appcompat/app/AlertDialog;

    const/4 v0, 0x1

    return v0
.end method
