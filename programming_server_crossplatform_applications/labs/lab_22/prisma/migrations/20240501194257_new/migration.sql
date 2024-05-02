BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[Subscribers] (
    [id] INT NOT NULL IDENTITY(1,1),
    [userId] INT,
    CONSTRAINT [PK__Subscrib__3213E83FFB1A0F90] PRIMARY KEY CLUSTERED ([id])
);

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH