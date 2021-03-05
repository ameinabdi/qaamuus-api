import { DataTypes } from 'sequelize';

/**
 * Subscription database model.
 * See https://sequelize.org/v5/manual/models-definition.html to learn how to customize it.
 */
export default function (sequelize) {
  const subscription = sequelize.define(
    'subscription',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      amount: {
        type: DataTypes.DECIMAL,
        allowNull: false,
        validate: {

        }
      },
      paymentType: {
        type: DataTypes.ENUM,
        values: [
          "EVC",
          "EDAHAB",
          "ZAAD",
          "SAHAL",
          "BANK",
          "CASH"
        ],
      },
      telephone: {
        type: DataTypes.INTEGER,
        allowNull: false,
        validate: {

        }
      },
      importHash: {
        type: DataTypes.STRING(255),
        allowNull: true,        
      },
    },
    {
      indexes: [
        {
          unique: true,
          fields: ['importHash', 'tenantId'],
          where: {
            deletedAt: null,
          },
        },

      ],
      timestamps: true,
      paranoid: true,
    },
  );

  subscription.associate = (models) => {
    models.subscription.belongsTo(models.user, {
      as: 'student',
      constraints: false,
    });


    
    models.subscription.belongsTo(models.tenant, {
      as: 'tenant',
    });

    models.subscription.belongsTo(models.user, {
      as: 'createdBy',
    });

    models.subscription.belongsTo(models.user, {
      as: 'updatedBy',
    });
  };

  return subscription;
}
