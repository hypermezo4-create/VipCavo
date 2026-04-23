# classes10.dex

.class public final synthetic Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda5;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field public final synthetic f$0:Landroidx/preference/EdSeekBarPreference;


# direct methods
.method public synthetic constructor <init>(Landroidx/preference/EdSeekBarPreference;)V
    .registers 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda5;->f$0:Landroidx/preference/EdSeekBarPreference;

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .registers 3

    iget-object v0, p0, Landroidx/preference/EdSeekBarPreference$$ExternalSyntheticLambda5;->f$0:Landroidx/preference/EdSeekBarPreference;

    invoke-virtual {v0, p1}, Landroidx/preference/EdSeekBarPreference;->lambda$onClickLogics$5$androidx-preference-EdSeekBarPreference(Landroid/view/View;)V

    return-void
.end method
