# classes3.dex

.class public final synthetic Lcom/android/settings/development/MemoryUsagePreferenceController$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/android/settings/development/MemoryUsagePreferenceController;

.field public final synthetic f$1:Ljava/lang/String;


# direct methods
.method public synthetic constructor <init>(Lcom/android/settings/development/MemoryUsagePreferenceController;Ljava/lang/String;)V
    .registers 3

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/android/settings/development/MemoryUsagePreferenceController$$ExternalSyntheticLambda1;->f$0:Lcom/android/settings/development/MemoryUsagePreferenceController;

    iput-object p2, p0, Lcom/android/settings/development/MemoryUsagePreferenceController$$ExternalSyntheticLambda1;->f$1:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public final run()V
    .registers 2

    iget-object v0, p0, Lcom/android/settings/development/MemoryUsagePreferenceController$$ExternalSyntheticLambda1;->f$0:Lcom/android/settings/development/MemoryUsagePreferenceController;

    iget-object p0, p0, Lcom/android/settings/development/MemoryUsagePreferenceController$$ExternalSyntheticLambda1;->f$1:Ljava/lang/String;

    invoke-static {v0, p0}, Lcom/android/settings/development/MemoryUsagePreferenceController;->$r8$lambda$IUiPa6oQiRgxY85OaCxt9WjJzTM(Lcom/android/settings/development/MemoryUsagePreferenceController;Ljava/lang/String;)V

    return-void
.end method
