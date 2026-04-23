# classes10.dex

.class public final synthetic Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda2;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/util/function/ToIntFunction;


# static fields
.field public static final synthetic INSTANCE:Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda2;


# direct methods
.method static synthetic constructor <clinit>()V
    .registers 1

    new-instance v0, Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda2;

    invoke-direct {v0}, Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda2;-><init>()V

    sput-object v0, Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda2;->INSTANCE:Lmobx/settings/overlay/icon/ThemeUtils$$ExternalSyntheticLambda2;

    return-void
.end method

.method private synthetic constructor <init>()V
    .registers 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final applyAsInt(Ljava/lang/Object;)I
    .registers 2

    check-cast p1, Landroid/content/om/OverlayInfo;

    invoke-static {p1}, Lmobx/settings/overlay/icon/ThemeUtils;->lambda$static$0(Landroid/content/om/OverlayInfo;)I

    move-result p1

    return p1
.end method
