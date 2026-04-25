# classes10.dex

.class Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$1;
.super Ljava/lang/Object;
.source "FontStylePreferenceDialogFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->onBindViewHolder(Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$MyViewHolder;I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;

.field final synthetic val$s:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;Ljava/lang/String;)V
    .registers 3

    iput-object p1, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$1;->this$0:Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;

    iput-object p2, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$1;->val$s:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .registers 4

    iget-object v0, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$1;->this$0:Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;

    invoke-static {v0}, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;->access$100(Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter;)Landroidx/preference/FontStylePreferenceDialogFragment;

    move-result-object v0

    iget-object v1, p0, Landroidx/preference/FontStylePreferenceDialogFragment$FileAdapter$1;->val$s:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroidx/preference/FontStylePreferenceDialogFragment;->onItemClick(Ljava/lang/String;)V

    return-void
.end method
